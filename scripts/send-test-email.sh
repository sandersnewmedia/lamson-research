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

echo "Who would you like to send to? [$USER-clipboard@sanderslabs.us]:"
read TO
if [ "$TO" = "" ]; then
    TO="$USER-clipboard@sanderslabs.us"
fi

echo "How many megabytes should the attachment be? (0 for no attachment) [0]:"
read SIZE
if [ "$SIZE" = "" ]; then
    SIZE=0
fi


if [ ! "$SIZE" = "0" ]; then
    echo "What should the filename be? (useful for testing mimetype handling) [delete-me.txt]:"
    read FILENAME
    if [ "$FILENAME" = "" ]; then
        FILENAME="delete-me.txt"
    fi
    ATTACHMENT=$PROJECT_ROOT/themailserver/app/data/$FILENAME
    rm -f $ATTACHMENT
    dd if=/dev/zero of=$ATTACHMENT bs=1048576 count=$SIZE > /dev/null 2>&1
    echo "Sending... please wait"
    lamson send -sender test@sanderslabs.us -to $TO -subject "Test email with attachment" -body "This is a test email" -attach $ATTACHMENT -port 8823 2>&1 | tail -n 4
    rm $ATTACHMENT
else
    echo "Sending... please wait"
    lamson send -sender test@sanderslabs.us -to $TO -subject "Test email" -body "This is a test email" -port 8823  2>&1
fi

echo "Done"
