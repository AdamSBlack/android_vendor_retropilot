#!/system/bin/sh
cd /data
export HOME=/data/data/com.termux/files/home
export PATH=/data/data/com.termux/files/usr/bin:/bin
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/data/data/com.termux/files/usr/local/lib64

if [ -d /data/retropilot]
then
  rm -rf /data/retropilot
fi

git clone --progress --verbose $1 /data/retropilot --recurse-submodules
ln -s /data/retropilot /data/openpilot