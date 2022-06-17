#!/system/bin/sh

# Elevated script for RetrOS
# Launches Openpilot


export HOME="/data/data/com.termux/files/home"
export PATH="/data/data/com.termux/files/usr/bin:/bin"
export LD_LIBRARY_PATH="/data/data/com.termux/files/usr/lib"
exec /system/bin/retros_userspace.sh
