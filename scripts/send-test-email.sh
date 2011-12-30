#!/bin/bash

# send a test email to the lamson server

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

echo "Who would you like to send to? (hit enter for default of $USER+clipboard@sanderslabs.us):"
read TO

if [ "$TO" = "" ]; then
    TO="$USER+clipboard@sanderslabs.us"
fi

lamson send -sender test@sanderslabs.us -to $TO -subject "Hello World!" -body "Hello World!" -port 8823
