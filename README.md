# AutoSetup

AutoSetup es un repositorio donde guardo los programas que más uso en mis maquinas corriendo linux.

tiene la siguiente estructura:
* Una serie de carpetas donde se guardan los archivos necesarios para la instalacion de cada programa
* Un script llamado **AutoInstall.py** que se encarga de instalar cada programa

## Las carpetas

Dentro de cada carpeta se encuentra uno o más archivos que contienen las instrucciones para instalar uno o más programas. **El nombre de la carpeta solo cumple propositos de organizacion** y no influlle en lo absoluto a la hora de la instalacion

En caso de querer añadir un nuevo programa a la lista de programas basta con crear una nueva carpeta dentro de la carpeta Programs con el nombre que desee, dentro de ésta carpeta crear cuantos archivos sea necesarios para instalar el programa 

Todos los archivos que se encuentran dentro de cada carpeta deben **incluir el interprete como primera linea.**


**Ejemplo: #!/bin/bash**

## El script AutoInstall.py

Este script se encarga de instalar los programas que se encuentran en la carpeta Programs.
y tiene las siguientes opciones:

Se ejecuta escribiendo **./AutoInstall.py** dentro de la carpeta AutoSetup

### Opciones basicas:
 **-i : Instalar un unico programa (se pasa como segundo argumento)**

 **-l : Mostrar todos los programas en la carpeta Programs**

 **-t : Instala todos los programas de la carpeta Programs**

### Opciones "avanzadas":

Estas opciones **usan un editor de texto**, si no se especifica un editor de texto **se usará el editor por defecto, vim**. puede usarse otro editor pasando el nombre del editor como argumento despues de la orden

**Ejemplo ./AutoInstall.py -d nano**  


**-d : Seleccionar los programas a no instalar (vim editor por defecto)**

**-s : Seleccionar los programas a instalar (vim editor por defecto)**

Cuando se ejecuten una de estas opciones **se ejecutará el editor de texto** elejido con un archivo temporal. en el caso de la opcion "-d" **todos los programas apareceran comentados** (es decir, con el signo # en primer lugar) y el usuario deberá **descomentar los que desee instalar**. En caso de usarse la opcion "-s" **todos los programas apareceran descomentados** y el usuario deberá **comentar los que no desee instalar**.
 
## Dependencias:

python3

