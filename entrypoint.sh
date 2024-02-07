#!/bin/bash
function StartUp() {
    cd /home/container
    CheckInstall
    exit 0
}

function CheckInstall() {
    if [ -z "$(ls -A /home/container)" ]; then
        wget http://158.101.169.52/unturned/unturned.tar.gz
        tar -xzvf unturned.tar.gz
        rm -r unturned.tar.gz
    fi
    Done
}

function Done() {
    export LD_LIBRARY_PATH="/home/container/linux64"
    # Replace Startup Variables
    MODIFIED_STARTUP=$(eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
    #for people still using the old version of the egg
    if [ -f server.log ]; then
        ln -sf /dev/stdout server.log
    fi
    #start unturned server
    eval ${MODIFIED_STARTUP}
}
StartUp
exit 0