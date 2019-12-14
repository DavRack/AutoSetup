#!/bin/bash

# configuraciones de touchpad
# Section "InputClass"
#         Identifier "libinput touchpad catchall"
#         MatchIsTouchpad "on"
#         MatchDevicePath "/dev/input/event*"
#         Driver "libinput"
#         Option "Tapping" "on"
#         Option "NaturalScrolling" "on"
# EndSection
# 
# en el archivo /usr/share/X11/xorg.conf.d/40-libinput.conf

# para usar el control de brillo de pantalla el usuario debe estar
# en el grupo video
# agregar usuario al grupo video
sudo usermod -a -G video $USER
