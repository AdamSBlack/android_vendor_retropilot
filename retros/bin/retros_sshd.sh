#!/system/bin/sh

# init race conditions

export HOME=/data/data/com.termux/files/home
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/usr/local/lib64
export PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin


if [ -d "/data/data/com.termux/files" ] 
then
 # setup ssh
 if [ ! -e /data/params/d/GithubSshKeys ] 
 then
 echo "SSH KEY NOT FOUND"
  mkdir -p /data/params/d
  exec /data/data/com.termux/files/usr/bin/ssh-keygen -y -f /data/data/com.termux/files/home/id_rsa > /data/params/d/GithubSshKeys
 fi
 # run sshd
 exec /data/data/com.termux/files/usr/bin/sshd -D
fi