#!/system/bin/sh

# init race conditions

export HOME=/data/data/com.termux/files/home
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/usr/local/lib64:
export PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin

EON_CHECK=$(cat /data/data/com.termux/.retros_setup)

if [ "$EON_CHECK" -ge "2" ] 
then
    # setup ssh
    if [ ! -e /data/params/d/GithubSshKeys ] 
    then
        echo "SSH KEY NOT FOUND"
        mkdir -p /data/params/d
        ssh-keygen -y -f /data/data/com.termux/files/home/id_rsa > /data/params/d/GithubSshKeys
    fi
    # run sshd
    echo "RUNNING SSHD"
    sshd -D
fi
