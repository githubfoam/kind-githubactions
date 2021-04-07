#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "============================deploy python 2x virtual environment============================================================="
    
python -V #Python 3.8.5
python2 --version #Python 2.7.18
python3 -V #Python 3.8.5
python3 --version #Python 3.8.5
pip --version
pip3 --version

apt-get update -qq
# sudo apt-get install python-pip -yqq #Unable to locate package python-pip

pip install virtualenv
pip install virtualenvwrapper

virtualenv -p /usr/bin/python2.7 ~venv27

source ~venv27/bin/activate
pip install -r requirements.txt
pip --version
pip3 --version

deactivate 

echo "============================deploy python 2x virtual environment============================================================="
    