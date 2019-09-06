#!/bin/bash

priority=${1}


apt install -y \
  build-essential pkg-config git automake autoconf \
  iptables-dev libipset-dev libnl-3-dev libnl-genl-3-dev libssl-dev \
  ipvsadm


pushd /tmp

wget https://github.com/acassen/keepalived/archive/v2.0.18.tar.gz
tar xf v2.0.18.tar.gz

pushd keepalived-2.0.18
./build_setup
./configure
make
make install

mkdir -p /etc/keepalived
cp /vagrant/scripts/keepalived/keepalived.conf /etc/keepalived/
chmod 644 /etc/keepalived/keepalived.conf

sed -i -e "s/#PRIORITY#/${priority}/" /etc/keepalived/keepalived.conf

systemctl enable keepalived
systemctl start keepalived

popd


popd

rm -rf /tmp/*


cat >> /etc/sysctl.conf <<EOD
net.ipv4.ip_forward = 1
net.ipv4.ip_nonlocal_bind=1
EOD

sysctl -p
