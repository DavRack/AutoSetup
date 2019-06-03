#!/bin/bash
sudo apt-get install bison libncurses5-dev libncursesw5-dev libxml2-dev libzip-dev -y
cd /tmp
git clone https://github.com/jmcnamara/libxlsxwriter.git
cd libxlsxwriter/
make
sudo make install
sudo ldconfig
cd ..
git clone https://github.com/andmarti1424/sc-im.git
cd sc-im/src
make
sudo make install
