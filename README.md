# PHP e MySQL - HA

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
