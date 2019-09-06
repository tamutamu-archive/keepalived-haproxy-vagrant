#!/bin/bash

dpkg --configure -a
apt update
apt -y upgrade
apt -y autoremove

apt -y install \
  vim \
  wget \
  zip \
  unzip \
  tcpdump \
  tmux

cat /vagrant/ssh_key.pub >> /home/vagrant/.ssh/authorized_keys
