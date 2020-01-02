#!/bin/bash

sudo apt install r-base -y

sudo su - -c "R -e \"install.packages('rmarkdown')\""
