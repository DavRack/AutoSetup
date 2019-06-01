#!/bin/bash

sudo apt install r-base

sudo su - -c "R -e \"install.packages('rmarkdown')\""
