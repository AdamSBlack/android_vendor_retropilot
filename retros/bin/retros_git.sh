#!/system/bin/sh
cd /data
export HOME=/data/data/com.termux/files/home
export PATH=/data/data/com.termux/files/usr/bin:/bin
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/data/data/com.termux/files/usr/local/lib64

if [ -d /data/retropilot]
then
  rm -rf /data/retropilot
fi

if [ ! -d /data/openpilot ]
then
  ln -s /data/retropilot /data/openpilot
fi

git clone --progress --verbose $1 /data/retropilot --recurse-submodules

rm /data/data/com.termux/.retros_setup
echo "4" > /data/data/com.termux/.retros_setup
