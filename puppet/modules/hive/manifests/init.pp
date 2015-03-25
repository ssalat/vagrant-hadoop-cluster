
class hive {
  
  require hive::base
  
}

class hive::base {
  
  require hive::package
  
  file { [ "/user", "/user/hive", "/user/hive/warehouse" ]:
    ensure => "directory",
    mode => 1777,
  }
  
  file { "hive-site":
    path => "/etc/hive/conf/hive-site.xml",
    ensure => file,
    content => template("hive/hive-site.xml.erb"),
    owner => "root",
    group => "root",
    mode => 644,
  }
  
  file { "mongo-hadoop-hive":
    path => "/usr/share/hive/lib/mongo-hadoop-hive_1.0.4-1.1.0.jar",
    ensure => file,
    source => "puppet:///modules/hive/mongo-hadoop-hive_1.0.4-1.1.0.jar",
    owner => "root",
    group => "root",
    mode => 644,
  }
  
  exec { "create-metastore-database":
    command => "/usr/bin/mysql -uroot -e \"CREATE DATABASE IF NOT EXISTS metastore;USE metastore;SOURCE /usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-0.8.0.mysql.sql;\"",
    require => Service["mysql"],
  }
  
  exec { "create-metastore-user":
    command => "/usr/bin/mysql -uroot -e \"GRANT USAGE ON *.* TO 'hive'@'localhost';DROP USER 'hive'@'localhost';FLUSH PRIVILEGES;CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'localhost';GRANT SELECT,INSERT,UPDATE,DELETE,LOCK TABLES,EXECUTE ON metastore.* TO 'hive'@'localhost';FLUSH PRIVILEGES;\"",
    require => [ Service["mysql"], Exec["create-metastore-database"] ],
  }
  
}

class hive::package {
  
  require hadoop::package
  
  package { [ "hive", "mysql-server", "libmysql-java" ]:
    ensure => "latest",
    require => Exec["apt-get update"],
  }
  
  package { [ "hive-server", "hive-metastore" ]:
    ensure => "latest",
    require => Package["hive"],
  }
  
  service { "mysql":
    enable => true,
    ensure => "running",
    require => Package["mysql-server"],
  }
  
  service { "hive-server":
    enable => true,
    ensure => "running",
    require => Package["hive-server"],
  }
  
  service { "hive-metastore":
    enable => true,
    ensure => "running",
    require => Package["hive-metastore"],
  }
  
  file { "/usr/lib/hive/lib/mysql-connector-java.jar":
    ensure => link,
    target => "/usr/share/java/mysql-connector-java.jar",
    require => Package["libmysql-java"],
  }
  
}
