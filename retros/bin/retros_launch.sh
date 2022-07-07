#!/system/bin/sh

# Just to abdstract it, need to do error handling
function copyUserspace() {
    export EXTRACT_UNSAFE_SYMLINKS=1
    busybox tar -xvf /system/etc/retros/files.tar.xz -C /data/data/com.termux
    echo "2" > /data/data/com.termux/.retros_setup
}

function launchUserspace() {
    export HOME=/data/data/com.termux/files/home
    export PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/data/data/com.termux/files/usr/local/lib64
    bash -C /system/bin/retros_userspace.sh
}

function disableLauncher() {
  echo "Disabling systemui" 
  LOOP_COUNT=0
  while [ $LOOP_COUNT -le 100 ]
  do
    pm disable com.android.systemui
    pm disable com.android.launcher3
    sleep 0.25
    LOOP_COUNT=$(( $LOOP_COUNT + 1 ))
  done
  echo "1" > /data/data/com.termux/.retros_setup
  echo "Disabled systemui" 
}

if [ -d "/data/tmp" ]
then
  rm -rf /data/tmp/*  
else
  mkdir /data/tmp
fi

# progress check
if [ ! -e "/data/data/com.termux/.retros_setup" ]
then
   echo "0" > /data/data/com.termux/.retros_setup
fi
EON_CHECK=$(cat /data/data/com.termux/.retros_setup)

# disable systemui and launcher3 if not already disabled

if [ "$EON_CHECK" -eq "0" ]
then
    disableLauncher
    reboot
fi

# Copying userspace files to /data/data/com.termux/files 
# If it doesn't exist. If it does, log and proceed.

if [ "$EON_CHECK" -eq "1" ]
then
    echo "RetrOS - Copying userspace files" 
    sleep 5
    am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.MainActivity --es "loading_reason" "Initializing userspace"
    copyUserspace
    echo "RetrOS - Completed copying userspace files"
    launchUserspace
else
  if [ "$EON_CHECK" -ge "2" ]
  then
      echo "RetrOS - Found userspace files.. booting"
      launchUserspace
  fi
fi
