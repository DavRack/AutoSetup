#!/usr/bin/env python3

import subprocess
import sys
import os

usuario = os.path.expanduser("~")

texto_header = '"# Los simbolos # denotan lineas que no serán interpretadas \n# las lineas que no comiencen con # se interpretaran como carpetas a instalar \n# remueva # alcomienzo de cada programa a instalar, remueva # en caso que no desee instalar dicho programa \n# cuando termine de editar el archivo guardelo y salga del editor \n# ¿Que programas desea instalar? \n \n \n'


def instalar_carpeta(carpeta):
    """instala los contenidos de una carpeta"""
    comando = "ls Programs/"+carpeta
    archivos = subprocess.check_output(comando, shell=True).decode("UTF-8").split("\n") 
    archivos = archivos[:-1]

    for archivo in archivos:
        comando = "chmod +x "+"Programs/"+carpeta+"/"+archivo
        subprocess.check_output(comando, shell=True).decode("UTF-8").split("\n") 

        comando = "./Programs/"+carpeta+"/"+archivo
        os.system(comando)
        print(" ")
        print(" ")


def instalar_todos():
    """Instala todos los programas de la carpeta programas"""
    if os.path.exists("Programs"):
        carpetas = subprocess.check_output("ls Programs", shell=True).decode("UTF-8").split("\n") 
        # crea una lista con todas las carpetas del directorio
        carpetas = carpetas[:-1]

        for carpeta in carpetas:

            instalar_carpeta(carpeta)

            print("Ejecutados todos los archivos de la carpeta "+carpeta)

    else:
        print("No existe la carpeta Programs")


def seleccionar(editor):
    """Abre un editor de texto donde el usuario pude
    seleccionar los programas que quiere instalar
    El editor por defecto es vim"""

    if os.path.exists("Programs"):
        carpetas = subprocess.check_output("ls Programs", shell=True).decode("UTF-8").split("\n") 
        # crea una lista con todas las carpetas del directorio
        carpetas = carpetas[:-1]
        texto = texto_header

        for carpeta in carpetas:
            texto = texto + '#' + carpeta + '\n'
        texto = texto + '"'
        comando = "echo "+texto+" > .temporal"
        os.system(comando)
        comando = editor+" .temporal"
        os.system(comando)
        contenido = subprocess.check_output("cat .temporal", shell=True).decode("UTF-8").split("\n") 
        os.system("rm .temporal")
        programas_instalar = []

        for linea in contenido:
            if len(linea) > 0 and linea[0] != "#" and linea != " ":
                programas_instalar.append(linea)

        for programa in programas_instalar:
            instalar_carpeta(programa)

    else:
        print("no existe la carpeta Programs")


def deseleccionar(editor):
    """Abre un editor de texto donde el usuario pude
    seleccionar los programas que no quiere instalar
    El editor por defecto es vim"""

    if os.path.exists("Programs"):
        carpetas = subprocess.check_output("ls Programs", shell=True).decode("UTF-8").split("\n") 
        # crea una lista con todas las carpetas del directorio
        carpetas = carpetas[:-1]
        texto = texto_header

        for carpeta in carpetas:
            texto = texto + carpeta + '\n'
        texto = texto + '"'
        comando = "echo "+texto+" > .temporal"
        os.system(comando)
        comando = editor+" .temporal"
        os.system(comando)
        contenido = subprocess.check_output("cat .temporal", shell=True).decode("UTF-8").split("\n") 
        os.system("rm .temporal")
        programas_instalar = []

        for linea in contenido:
            if len(linea) > 0 and linea[0] != "#" and linea != " ":
                programas_instalar.append(linea)

        for programa in programas_instalar:
            instalar_carpeta(programa)

    else:
        print("no existe la carpeta Programs")


def mostrar_programas():
    """muestra todos los programas de la carpeta Programs"""
    carpetas = subprocess.check_output("ls Programs", shell=True).decode("UTF-8").split("\n") 
    for programa in carpetas:
        print(programa)


ayuda = "\
         -d : Seleccionar los programas a no instalar \n\
         -i : Instalar un unico programa (se pasa como segundo argumento) \n\
         -l : Mostrar todos los programas en la carpeta Programs \n\
         -s : Seleccionar los programas a instalar (vim editor por defecto) \n\
         -t : Instala todos los programas de la carpeta Programs \n\
         -h : Muestra ésta ayuda"


if len(sys.argv) >= 2 and len(sys.argv) <= 3:
    argumento = sys.argv[1]

    if argumento == "-t":
        instalar_todos()

    elif argumento == "-s":
        editor = "vim"
        if len(sys.argv) == 3:
            editor = sys.argv[2]
        seleccionar(editor)

    elif argumento == "-d":
        editor = "vim"
        if len(sys.argv) == 3:
            editor = sys.argv[2]
        deseleccionar(editor)

    elif argumento == "-i":
        if len(sys.argv) == 3:
            programa = sys.argv[2]
            instalar_carpeta(programa)
        else:
            print("Numero incorrecto de argumentos")

    elif argumento == "-l":
        mostrar_programas()

    else:
        print(ayuda)


elif len(sys.argv) == 1:
    print("Se necesita un argumento")
    print(ayuda)

elif len(sys.argv) > 3:
    print("demasiados argumentos")
