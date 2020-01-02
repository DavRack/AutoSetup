#!/bin/bash
shopt -s lastpipe # no generar subshells para mantener variables

csv=programas.csv # nombre del csv con los programas por defecto

function ayuda (){
    echo "Uso:
        ./AutoInstall.sh -[comando] <argumento>
                Nota: Si no se especifica un grupo se instalan
                los programas de todos los grupos

        -g: <grupo> Instala los programas en el grupo especificado.
        -h: Muestra esta pagina de ayuda
        -p: <grupo> Instala los programas solo desde gestor de paquetes.
        -s: <grupo> Instala los programas solo desde los scripts.
        "
}
function getToInstall () {
    f='True'
    paquetes=()
    scripts=()
    cat $csv | while read line
    do
        if [ "$f" != "True" ] # lee cada linea excepto la primera
        then
            comando=$(echo $line | cut -d',' -f3)     
            grupo=$(echo $line | cut -d',' -f4)
            nombre=$(echo $line | cut -d',' -f1)
            grupoAInstalar=$1
            if [[ "$grupo" == *"$grupoAInstalar"* ]] || [ "$grupoAInstalar" == "" ]
            then    
                if [ "${comando: -3}" != ".sh" ] # ignora los programas que se instalan con script
                then
                    if [ "$comando" != "" ] # si el comando está vacio usar nombre como comando 
                    then
                        paquetes+=($comando)
                    else
                        paquetes+=($nombre)
                    fi
                else
                    scripts+=($comando)
                fi
            fi
        else
            f=False
        fi
    done
}
function installGroup (){ # recibe el argumento: grupoAInstalar
    getToInstall $1 
    echo "Programas a instalar desde el gestor de paquetes: "
    echo "================================================"
    echo ${paquetes[@]}
    echo " "
    sudo apt install -y $(echo ${paquetes[@]})
    installFromScript $1
}
function installFromScript () {
    getToInstall $1
    echo "Programas a instalar desde scripts: "
    echo "=================================="
    echo ${scripts[@]}
    echo " "
    for file in ${scripts[@]}
    do
        chmod +x scripts/$file
        scripts/$file
    done
}
function installFromManager () {
    getToInstall $1
    echo "Programas a instalar desde el gestor de paquetes:"
    echo "================================================"
    echo ${paquetes[@]}
    sudo apt install -y $(echo ${paquetes[@]})
}
if [ "$1" == "-h" ] || [ "$1" == "" ]
then
    ayuda
elif [ "$1" == "-g" ]
then
    installGroup "$2"
elif [ "$1" == "-p" ]
then
    installFromManager "$2"
elif [ "$1" == "-s" ]
then
    installFromScript "$2"
fi
