#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
/etc/init.d/redis-server stop
service cron stop
service ssh stop
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw allow http
sudo ufw allow https
MOREFSUN="$(netstat -ant |grep LISTEN | awk '{ print $4 }' | sed 's/.*://')";

echo "${MOREFSUN}";

echo "closing...";

fuser -k -n tcp ${MOREFSUN};


