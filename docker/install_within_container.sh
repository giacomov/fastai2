#!/bin/bash

set -e
set -x

cd /root

# Install minimal packages needed
apt update
apt install -y git wget

# Install Miniconda

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod u+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda3
export PATH=/miniconda3/bin:${PATH}

# Clone and install fastai2 and create fastai2 conda env
# with all the dependencies needed by fastai2

cd /root/fastai2
conda env create -f environment.yml
source activate fastai2
conda install -y jupyterlab nodejs ipympl

# Instruct pip not to use any caching, so the image
# stays small
pip config set global.cache-dir false

# Install fastai2
pip install .
cd /root

# Install the latest fastcore

git clone https://github.com/fastai/fastcore
cd fastcore
pip install .
cd ..

# Clean conda cache
conda clean --all -y
rm -rf /miniconda3/pkgs/*

# Free up some space

# Remove git and wget
apt-get purge -y git wget
apt-get --purge -y autoremove

# Remove repositories
rm -rf fastai2
rm -rf fastcore

# Remove Miniconda installer
rm -rf Miniconda3*.sh

# Clean apt cache
rm -rf /var/lib/apt/lists/*
