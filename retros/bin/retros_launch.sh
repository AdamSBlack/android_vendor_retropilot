#!/system/bin/sh

pm disable com.android.systemui
pm disable com.android.launcher3

# Just to abdstract it, need to do error handling
function copyUserspace() {
 export EXTRACT_UNSAFE_SYMLINKS=1
 busybox tar -xvf /system/etc/retros/files.tar.xz -C /data/data/com.termux
}


# Copying userspace files to /data/data/com.termux/files 
# If it doesn't exist. If it does, log and proceed.

if [ ! -d "/data/data/com.termux/files" ] 
then
    echo "RetrOS - Copying userspace files" 
    copyUserspace
    echo "RetrOS - Completed copying userspace files"
else
    echo "RetOS - Found userspace files.. booting"
fi


# If a file is detetcted in /data/data/com.termux/reinstall
# it will uninstall the userspace and reinstall, this isn't
# a great way to do it, but for now good enough.

if [ -d "/data/data/com.termux/reinstall" ] 
then
    echo "RetrOS - Userspace reinstall requested"
    rm -rf /data/data/com.termux/files
    echo "RetrOS - Deleted userspace files"
    copyUserspace
    echo "Retros - Completed copying userspace files"
fi

# Symlink exists to point /tmp to /data/retros/tmp
# Ensuring it exists, if not it's created
# Directory is cleared every boot

if [ ! -d "/data/tmp" ] 
then
    mkdir -p /data/tmp
else
    rm -rf /data/tmp/*
fi

#
#
#

