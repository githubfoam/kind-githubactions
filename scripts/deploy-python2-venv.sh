#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "============================deploy python 2x virtual environment============================================================="
    
python -V #Python 3.8.5
python3 -V #Python 3.8.5
python2 --version #Python 2.7.18
python3 --version #Python 3.8.5
pip --version #pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8
pip3 --version #pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)

apt-get update -qq
# sudo apt-get install python-pip -yqq #Unable to locate package python-pip

pip install virtualenv
virtualenv --version #
pip install virtualenvwrapper

which python
which python2
which python3
virtualenv -p /usr/bin/python2.7 ~venv27

source ~venv27/bin/activate
pip install -r requirements.txt
python -V #Python  2.7.18
python3 -V #Python 3.8.5
python2 --version #Python 2.7.18
python3 --version #Python 3.8.5
pip --version #pip 20.3.4 from /home/runner/work/kind-githubactions/kind-githubactions/~venv27/lib/python2.7/site-packages/pip (python 2.7)
pip3 --version #pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)

deactivate 

echo "============================deploy python 2x virtual environment============================================================="
    