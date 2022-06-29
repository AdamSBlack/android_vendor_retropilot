#!/system/bin/sh

# Just to abdstract it, need to do error handling
function copyUserspace() {
    export EXTRACT_UNSAFE_SYMLINKS=1
    busybox tar -xvf /system/etc/retros/files.tar.xz -C /data/data/com.termux
    ln -s /data/data/com.termux/files/usr /usr
    mkdir -p /data/tmp
    ln -s /data/tmp /tmp
    echo "2" > /data/data/com.termux/.retros_setup
}

function launchUserspace() {
    export HOME=/data/data/com.termux/files/home
    export PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/data/data/com.termux/files/usr/local/lib64
    bash -C /system/bin/retros_userspace.sh
}

function disableLauncher(){ 
  while true; do
    if ! pm list packages -d 2>/dev/null | grep -e com.android.systemui -e com.android.launcher3; then
      echo "Disabling systemui"
      pm disable com.android.systemui
      pm disable com.android.launcher3
      sleep 1
    else
      break
    fi
  done
}

# disable systemui and launcher3 if not already disabled
if ! pm list packages -d 2>/dev/null | grep -e com.android.systemui;
then
disableLauncher
fi

# progress check
if [ ! -e "/data/data/com.termux/.retros_setup" ]
then
   echo "0" > /data/data/com.termux/.retros_setup
fi

# Symlink exists to point /tmp to /data/retros/tmp
# Ensuring it exists, if not it's created
# Directory is cleared every boot

if [ -d "/data/tmp" ] 
then
    rm -rf /data/tmp/*
fi

# Copying userspace files to /data/data/com.termux/files 
# If it doesn't exist. If it does, log and proceed.
EON_CHECK=$(cat /data/data/com.termux/.retros_setup)
if [ ! "$EON_CHECK" -eq "2" ]
then
    echo "RetrOS - Copying userspace files" 
    am start -n org.retropilot.retros.dumbspinner/org.retropilot.retros.dumbspinner.MainActivity --es "loading_reason" "Initializing userspace"
    copyUserspace
    echo "RetrOS - Completed copying userspace files"
    launchUserspace
else
    echo "RetrOS - Found userspace files.. booting"
    launchUserspace
fi


# If a file is detetcted in /data/data/com.termux/reinstall
# it will uninstall the userspace and reinstall, this isn't
# a great way to do it, but for now good enough.

if [ -e "/data/data/com.termux/reinstall" ] 
then
    echo "RetrOS - Userspace reinstall requested"
    rm -rf /data/data/com.termux/files
    echo "RetrOS - Deleted userspace files"
    copyUserspace
    echo "Retros - Completed copying userspace files"
fi
