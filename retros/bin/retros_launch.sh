#!/system/bin/sh

# Just to abdstract it, need to do error handling
function copyUserspace() {
 export EXTRACT_UNSAFE_SYMLINKS=1
 busybox tar -xvf /system/etc/retros/files.tar.xz -C /data/data/com.termux
 reboot
}

# Symlink exists to point /tmp to /data/retros/tmp
# Ensuring it exists, if not it's created
# Directory is cleared every boot

if [ ! -d "/data/tmp" ] 
then
    mkdir -p /data/tmp
else
    rm -rf /data/tmp/*
fi

# disable systemui and launcher3... this is ugly, but needs to be done first
while true; do
  if ! pm list packages -d 2>/dev/null | grep -e com.android.systemui -e com.android.launcher3; then
    echo "Disabling systemui"
    pm disable com.android.systemui
    pm disable com.android.launcher3
  else
    break
  fi
done

# Copying userspace files to /data/data/com.termux/files 
# If it doesn't exist. If it does, log and proceed.

if [ ! -d "/data/data/com.termux/files" ] 
then
    echo "RetrOS - Copying userspace files" 
    copyUserspace
    echo "RetrOS - Completed copying userspace files"
else
    echo "RetrOS - Found userspace files.. booting"
    export HOME=/data/data/com.termux/files/home
    export PATH=/data/data/com.termux/files/usr/bin:/bin
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
    cd /system/bin/
    ./retros_userspace.sh
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
