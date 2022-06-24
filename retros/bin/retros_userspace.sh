#!/usr/bin/bash
export TERM=xterm-256color

# check if userspace is finished installing, if not then install
if [ ! -e "/data/data/com.termux/files/retros_setup_complete" ]
then
  # do not progress until there's an internet connection
  cd /system/bin
  while true; do
    if ping -c 1 8.8.8.8; then
      break
    fi
    ./retros_android_settings.sh
    sleep 1
  done
  cd /data/data/com.termux/files/home/
  if [ -d "/tmp/build" ] 
  then
    rm -rf /tmp/build
  fi
  # doing this in tmux so it can be monitored over SSH
  tmux new-session -d -s retropilot_setup ./install.sh
  exit
fi

if [ -d "/data/openpilot/" ]
then
    cd /data/openpilot
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/data/data/com.termux/files/usr/local/lib64
    tmux new-session -d -s retropilot ./launch_openpilot.sh
else
    echo "RetrOS - Unable to find openpilot install"
    cd /system/bin
    ./retros_android_settings.sh
fi

