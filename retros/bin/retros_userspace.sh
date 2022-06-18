#!/usr/bin/bash

if [ -d "/data/openpilot/" ] 
then
    exec /data/openpilot/launch_openpilot.sh
else
    echo "RetrOS - Unable to find openpilot install"
fi


