#!/bin/bash
shopt -s lastpipe # no generar subshells para mantener variables

csv=programas.csv # nombre del csv con los programas por defecto

function ayuda (){
    echo "Uso:
        -h: Muestra esta pagina de ayuda
        -d: Instalar todos los programas en el grupo por defecto
        -a: Instala todos los programas
        -g: Instala todos los programas en el grupo especificado
        "
}
function installGroup (){ # recibe el argumento: grupoAInstalar
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
            if [ "$grupo" == "$grupoAInstalar" ] || [ "$grupoAInstalar" == "" ]
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
    echo "Programas a instalar desde el gestor de paquetes: "${paquetes[@]}
    echo "================================================"
    echo " "
    echo "Programas a instalar desde scripts: "${scripts[@]}
    echo "=================================="
    echo " "
    sudo apt install -y $(echo ${paquetes[@]})
    installFromScript $scripts
    
}
function installFromScript () {
    for file in ${scripts[@]}
    do
        chmod +x scripts/$file
        scripts/$file
    done
}
#installDefaults

if [ "$1" == "-h" ] || [ "$1" == "" ]
then
    ayuda
elif [ "$1" == "-a" ]
then
    installGroup "" # instalar todas las aplicaciones
elif [ "$1" == "-g" ]
then
    installGroup "$2"
fi
