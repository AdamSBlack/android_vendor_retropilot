#!/usr/bin/bash
export TERM=xterm-256color


if [ -d "/data/openpilot/" ]
then
    cd /data/openpilot
    ./launch_openpilot.sh
else
    echo "RetrOS - Unable to find openpilot install"
    cd /system/bin
    ./retros_android_settings.sh
fi

