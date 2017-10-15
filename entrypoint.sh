#!/bin/bash 
# -----------------------------------
set -e

sed "/apt-cacher-ng/d" /etc/passwd > /etc/passwd
sed "/apt-cacher-ng/d" /etc/group > /etc/group

groupadd -g 117 apt-cacher-ng 
echo "group add"

useradd -u 117  \
        -g 117 \
       	-s "/bin/false" \
       	-d "/var/cache/apt-cacher-ng" \
       	apt-cacher-ng
echo "useradd"

chown -R ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} /var/cache/apt-cacher-ng/
echo "chown cache"
chown -R ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} /var/log/apt-cacher-ng/
echo "chown log"

# create pid directory
mkdir -p /var/run/apt-cacher-ng
echo "mkdir /var/run"
chmod -R 0755 /var/run/apt-cacher-ng
echo "chmod /var/run"
chown ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} /var/run/apt-cacher-ng
echo "chown /var/run"
chown 0:${APT_CACHER_NG_USER} /etc/apt-cacher-ng/security.conf
echo "chown /security.conf"

/etc/init.d/apt-cacher-ng start
tail -f /var/log/apt-cacher-ng/*
