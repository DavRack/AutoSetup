#!/bin/bash

mkdir -p ~/programas
cd ~/programas
git clone https://github.com/polybar/polybar.git
cd polybar
mkdir build
cd build/
cmake ..
make -j$(nproc)
sudo make install
