#!/bin/bash
function StartUp() {
    cd /home/container
    Done
    exit 0
}

function Done() {
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