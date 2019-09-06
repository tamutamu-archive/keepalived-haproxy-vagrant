#!/bin/bash


### For haproxy log
cp /vagrant/scripts/haproxy/haproxy.conf /etc/rsyslog.d/
systemctl restart rsyslog


### Install Haproxy
apt install -y build-essential lua5.3 lua5.3-dev libssl-dev libpcre3-dev zlib1g-dev libsystemd-dev

pushd /tmp

wget http://www.haproxy.org/download/2.0/src/haproxy-2.0.5.tar.gz
tar xf haproxy-2.0.5.tar.gz

pushd haproxy-2.0.5
make clean
make -j $(nproc) TARGET=linux-glibc \
                  USE_OPENSSL=1 USE_ZLIB=1 USE_LUA=1 USE_PCRE=1 USE_SYSTEMD=1
make install

pushd contrib/systemd/
make
cp haproxy.service /lib/systemd/system/
popd

popd

mkdir -p /etc/haproxy
cp /vagrant/scripts/haproxy/haproxy.cfg /etc/haproxy/

systemctl enable haproxy
systemctl start haproxy

rm -rf /tmp/*

### LVS NAT
#route add default gw 192.168.1.200
#route del -net 192.168.1.0 netmask 255.255.255.0

### LVS DR

echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean false | debconf-set-selections
apt-get -y install iptables-persistent


iptables -t nat -A PREROUTING -d 192.168.1.200 -j REDIRECT
