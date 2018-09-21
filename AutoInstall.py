#!/usr/bin/env python3
import subprocess
import sys
import os
usuario = os.path.expanduser("~")


def instalar_todos():

    if os.path.exists("Programs"):
        carpetas = subprocess.check_output("ls Programs",shell=True).decode("UTF-8").split("\n") 
        #crea una lista con todas las carpetas del directorio 
        carpetas = carpetas[:-1]

        for carpeta in carpetas:
            comando = "ls Programs/"+carpeta
            archivos = subprocess.check_output(comando,shell=True).decode("UTF-8").split("\n") 
            archivos = archivos[:-1]

            for archivo in archivos:
                comando = "chmod +x "+"Programs/"+carpeta+"/"+archivo 
                out = subprocess.check_output(comando,shell=True).decode("UTF-8").split("\n") 

                comando = "./Programs/"+carpeta+"/"+archivo 
                out = os.system(comando)
                print(out)

            print("Ejecutados todos los archivos de la carpeta "+carpeta)

    else:
        print("No existe la carpeta Programs")

ayuda = "\
         -t : Instala todos los programas de la carpeta Programs \n\
         -h : Muestra ésta ayuda"


if len(sys.argv) == 2:
    argumento = sys.argv[1]

    if argumento == "-t":
        instalar_todos()

    elif argumento == "-h":
        print(ayuda)


elif len(sys.argv) == 1:
    print("Se necesita un argumento")
    print(ayuda)

elif len(sys.argv) > 2:
    print("demasiados argumentos")

