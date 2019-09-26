#!/bin/bash

apt install -y openjdk-8-jdk

pushd /tmp
#wget http://ftp.yz.yamagata-u.ac.jp/pub/network/apache//jmeter/binaries/apache-jmeter-5.1.1.tgz
#tar xf apache-jmeter-5.1.1.tgz
mv apache-jmeter-5.1.1 /opt/

mkdir -p /opt/scripts
cp Test.jmx start_jmeter.sh /opt/scripts/

popd
