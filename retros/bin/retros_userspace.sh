#!/usr/bin/bash
export TERM=xterm-256color

if [ ! -d "/data/openpilot/" ] 
then
  # check if userspace is finished installing, if not then install
  if [ ! -e "/data/data/com.termux/files/retros_setup_complete" ]
  then
    # do not progress until there's an internet connection
    cd /system/bin
    while true; do
      if ping -c 1 8.8.8.8; then
        break
      fi
      sleep 1
    done
    
    cd /data/data/com.termux/files/home/
    # doing this in tmux so it can be monitored over SSH
    tmux new-session -d -s retropilot_setup ./install.sh
    # launch the spinner
    am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.MainActivity --es "loading_reason" "Installing components"
  else
    am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.fork_select
  fi
else
  cd /data/openpilot
  tmux new-session -d -s retropilot ./launch_openpilot.sh
fi
