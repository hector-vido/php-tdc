# PHP e MySQL - HA

Para provisionar as máquinas utilizadas no TDC será preciso instalar o [Vagrant](https://www.vagrantup.com/) e algum hypervisor como por exemplo o [Virtualbox](https://www.virtualbox.org/).

Clone o repositório, entre no diretório e inicie o provisionamento:

```bash
git clone https://github.com/hector-vido/php-tdc.git
cd php-tdc
vagrant up
```

Na primeira execução, uma imagem do Debian (conhecida como box) será baixada e então as máquinas passarão a ser criadas e então a instalação começará.

## Manipulando as máquinas

Para visualizar as máquinas basta executar:

  vagrant status

Para acessar qualquer uma das máquinas basta executar:

  vagrant ssh master

Para ligar e desligar as máquinas:

  vagrant up
  vagrant halt

## MySQL

### db1

```sql
CREATE USER 'replicator'@'172.27.11.22' IDENTIFIED WITH mysql_native_password BY '4linux';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'172.27.11.22';

CREATE DATABASE tdc;
CREATE USER tdc@'%' IDENTIFIED WITH mysql_native_password BY '4linux';
GRANT ALL ON tdc.* TO tdc@'%';
```

```bash
mysql -u root -p4linux < /vagrant/files/innodb_memcached_config.sql
# 5.7 mysql -u root -p4linux < /usr/share/mysql/innodb_memcached_config.sql
# 8.0 mysql -u root -p4linux < /usr/share/mysql-8.0/innodb_memcached_config.sql
```

```sql
INSTALL PLUGIN daemon_memcached SONAME "libmemcached.so";
```

### db2

```sql
CHANGE MASTER TO
MASTER_HOST='172.27.11.11',
MASTER_USER='replicator',
MASTER_PASSWORD='4linux',
MASTER_LOG_FILE='binlog.000001',
MASTER_LOG_POS=4;

START SLAVE;

INSTALL PLUGIN daemon_memcached SONAME "libmemcached.so";
``` 
