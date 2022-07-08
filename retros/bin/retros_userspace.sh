#!/usr/bin/bash
export TERM=xterm-256color
EON_CHECK=$(cat /data/data/com.termux/.retros_setup)

if [ "$EON_CHECK" -le "3" ] 
then
  # check if userspace is finished installing, if not then install
  if [ "$EON_CHECK" -eq "2" ]
  then
    # start the wifi selector-o-matik
    am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.wifi

    # do not progress until there's an internet connection
    while true; do
      if ping -c 1 8.8.8.8; then
        break
      fi
      sleep 1
    done
 
    cd /data/data/com.termux/files/home/
    # doing this in tmux so it can be monitored over SSH
    tmux new-session -d -s retropilot_setup /usr/bin/bash ./install.sh
    # launch the spinner

    pm disable org.retropilot.retros.dumbspinner && pm enable org.retropilot.retros.dumbspinner
    am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.MainActivity --es "loading_reason" "Installing components"

    # wait until setup finishes
    while true; do
      sleep 1
      if [ -e "/data/data/com.termux/files/retros_setup_complete" ]
      then
        echo "3" >| /data/data/com.termux/.retros_setup
        break
      fi
    done
  fi
  rm /data/data/com.termux/files/.fork_url
  am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.fork_select
  
  # Waiting for .fork_url to exist
  while true; do
    sleep 1
    if [ -e "/data/data/com.termux/files/.fork_url" ]
      then
        break
    fi
  done
  
  # This file will contain the desired url to install
  fork_url=`cat /data/data/com.termux/files/.fork_url`
  
  # dirty hack
  pm disable org.retropilot.retros.dumbspinner
  pm enable org.retropilot.retros.dumbspinner
  
  am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.MainActivity --es "loading_reason" "Getting started...."
  
  if [ -d /data/retropilot]
  then
    rm -rf /data/retropilot
  fi

  if [ ! -h /data/openpilot ]
    then
      ln -s /data/retropilot /data/openpilot
  fi
  
  git clone --verbose $fork_url /data/retropilot --recurse-submodules > /data/retros_git.log 2>&1
  if [[ $? -eq 0 ]];
    then
      echo "4" >| /data/data/com.termux/.retros_setup
      cd /data/openpilot
      tmux new-session -d -s retropilot /usr/bin/bash ./launch_openpilot.sh
      pm disable org.retropilot.retros.dumbspinner
      pm enable org.retropilot.retros.dumbspinner
    else
      am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.MainActivity --es "loading_reason" "Git clone failed, check /data/retros_git.log"
  fi
  
else
  cd /data/openpilot
  tmux new-session -d -s retropilot /usr/bin/bash ./launch_openpilot.sh
fi
