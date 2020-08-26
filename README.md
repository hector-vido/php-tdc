# PHP e MySQL - HA

## MySQL

```sql
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
