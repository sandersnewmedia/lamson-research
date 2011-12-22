#!/bin/sh

# install script for lamson-research

############################################################################################
#
#  / ___|  __ _ _ __   __| | ___ _ __ ___  | \ | | _____      __ |  \/  | ___  __| (_) __ _
#  \___ \ / _` | '_ \ / _` |/ _ \ '__/ __| |  \| |/ _ \ \ /\ / / | |\/| |/ _ \/ _` | |/ _` |
#   ___) | (_| | | | | (_| |  __/ |  \__ \ | |\  |  __/\ V  V /  | |  | |  __/ (_| | | (_| |
#  |____/ \__,_|_| |_|\__,_|\___|_|  |___/ |_| \_|\___| \_/\_/   |_|  |_|\___|\__,_|_|\__,_|
#
#############################################################################################

# get path to current script and the project
PROJECT_ROOT=$( cd "$( dirname "$_" )/../"; pwd)

# install needed system tools to setup the virtualenv
sudo python ${PROJECT_ROOT}/scripts/ez_setup.py
sudo easy_install pip virtualenv

# setup the virtualenv
cd $PROJECT_ROOT
virtualenv pyenv --no-site-packages

# install the requirements
. pyenv/bin/activate
wget http://pypi.python.org/packages/source/n/nose/nose-1.1.2.tar.gz#md5=144f237b615e23f21f6a50b2183aa817
tar xzf nose-1.1.2.tar.gz
cd nose-1.1.2
python setup.py install
cd ..
rm -R nose-*
pip install -r ${PROJECT_ROOT}/scripts/requirements.txt
deactivate
