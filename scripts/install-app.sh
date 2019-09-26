#!/bin/bash -e

hostName=${1}

pushd /vagrant/scripts

M2_PATH=/etc/maven

apt install -y openjdk-8-jdk maven

if [ ! -z "$http_proxy" ]; then
   proxy_host=$(echo $http_proxy | awk '{sub("^http.*://","");sub(":[0-9]*","");print $0}')
   proxy_port=$(echo $http_proxy | awk '{sub("^http.*:","");print $0}')
   non_proxy_hosts=$(echo $no_proxy | awk '{gsub(",","|");print $0}')

   cat ${M2_PATH}/settings.xml | \
     gawk -f ./add_proxy.awk -v PROXY_HOST="${proxy_host}" -v PROXY_PORT="${proxy_port}" -v NON_PROXY_HOSTS="${non_proxy_hosts}" > ${M2_PATH}/settings.xml.tmp

   mv ${M2_PATH}/settings.xml.tmp ${M2_PATH}/settings.xml
 fi

hostnamectl set-hostname ${hostName}

cp demo.zip /tmp/
rm -rf /tmp/demo
unzip /tmp/demo.zip -d /tmp/
mv /tmp/demo /opt/

pushd /opt/demo
mvn clean package
popd

cp demo.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable demo
systemctl start demo


popd
