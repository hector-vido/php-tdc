#!/bin/bash

apt-get update
apt-get install -y php-dev php-pear php-mysql vim curl git lsb-release

wget -O - 'https://repo.proxysql.com/ProxySQL/repo_pub_key' | apt-key add -
echo deb https://repo.proxysql.com/ProxySQL/proxysql-2.0.x/$(lsb_release -sc)/ ./ \ | tee /etc/apt/sources.list.d/proxysql.list

apt-get update
apt-get install -y proxysql
