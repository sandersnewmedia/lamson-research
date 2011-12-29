#!/bin/sh

# run script for lamson-research

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

if [ ! -d "$PROJECT_ROOT/pyenv" ]; then
    echo "You must run install.sh to install the project first"
    exit 1
fi

cd $PROJECT_ROOT
. pyenv/bin/activate
cd themailserver

# stop all lamson processes
lamson stop -KILL True -ALL `pwd`/run

# exeunt virtualenv
deactivate
