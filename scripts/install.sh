#!/bin/bash

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

check_installed(){
    if [ -d "$PROJECT_ROOT/pyenv" ]; then
        echo ""
        echo "Already installed. To reinstall, delete"
        echo "$PROJECT_ROOT/pyenv"
        echo "and run this script again."
        echo ""
        exit 1
    fi
}

create_virtualenv(){
    # install needed system tools to setup the virtualenv
    if ! which easy_install >/dev/null; then
        sudo python ${PROJECT_ROOT}/scripts/ez_setup.py
    fi

    if ! which pip >/dev/null; then
        sudo easy_install pip
    fi

    if ! which virtualenv >/dev/null; then
        sudo easy_install virtualenv
    fi

    # setup the virtualenv
    cd $PROJECT_ROOT
    virtualenv pyenv --no-site-packages
}

install_requirements(){
    # install the requirements
    . pyenv/bin/activate

    # installing nose via pip requirements was hanging, so download the tarball and install manually
    wget http://pypi.python.org/packages/source/n/nose/nose-1.1.2.tar.gz#md5=144f237b615e23f21f6a50b2183aa817
    tar xzf nose-1.1.2.tar.gz
    cd nose-1.1.2
    python setup.py install
    cd ..
    rm -R nose-*
    pip install -r ${PROJECT_ROOT}/scripts/requirements.txt

    # patch lamson so that it can run a debug server
    cd $PROJECT_ROOT/pyenv/lib/python2.7/site-packages/
    wget -O- https://github.com/zedshaw/lamson/pull/2.patch > lamson-debug-server.patch
    patch -p1 < lamson-debug-server.patch
    rm lamson-debug-server.patch

    # exeunt virtualenv
    deactivate
}


check_installed
create_virtualenv
install_requirements

echo "Installation complete"
