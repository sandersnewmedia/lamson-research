#!/bin/bash

# start script for lamson-research

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

echo "For development purposes, consider using run.sh instead; this should be used for production"

cd $PROJECT_ROOT
. pyenv/bin/activate
cd themailserver

# start the server & start the logger
echo "[starting lamson]"
lamson start
lamson log
echo "[started lamson]"

# exeunt virtualenv
deactivate
