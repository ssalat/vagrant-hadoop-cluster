
class hadoop {
  
  require hadoop::base
  
}

class hadoop::datanode {
  
  require hadoop::base
  
  package { "hadoop-datanode":
    ensure => "latest",
  }
  
}

class hadoop::namenode {
  
  require hadoop::base
  
  package { "hadoop-namenode":
    ensure => "latest",
  }
  
}

class hadoop::tasktracker {
  
  require hadoop::base
  
  package { "hadoop-tasktracker":
    ensure => "latest",
  }
  
}

class hadoop::jobtracker {
  
  require hadoop::base
  
  package { "hadoop-jobtracker":
    ensure => "latest",
  }
  
}

class hadoop::base {
  
  require hadoop::package
  
  file { "masters":
    path => "/etc/hadoop/conf/masters",
    ensure => file,
    content => template("hadoop/masters.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "slaves":
    path => "/etc/hadoop/conf/slaves",
    ensure => file,
    content => template("hadoop/slaves.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "hadoop-env":
    path => "/etc/hadoop/conf/hadoop-env.sh",
    ensure => file,
    content => template("hadoop/hadoop-env.sh.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "core-site":
    path => "/etc/hadoop/conf/core-site.xml",
    ensure => file,
    content => template("hadoop/core-site.xml.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "hdfs-site":
    path => "/etc/hadoop/conf/hdfs-site.xml",
    ensure => file,
    content => template("hadoop/hdfs-site.xml.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "mapred-site":
    path => "/etc/hadoop/conf/mapred-site.xml",
    ensure => file,
    content => template("hadoop/mapred-site.xml.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "log4j-properties":
    path => "/etc/hadoop/conf/log4j.properties",
    ensure => file,
    content => template("hadoop/log4j.properties.erb"),
    owner => "root",
    group => "hadoop",
    mode => 644,
  }
  
  file { "mongo-java-driver":
    path => "/usr/share/java/mongo-java-driver-2.7.3.jar",
    ensure => file,
    source => "puppet:///modules/hadoop/mongo-java-driver-2.7.3.jar",
    owner => "root",
    group => "root",
    mode => 644,
  }
  
  file { "/usr/lib/hadoop/lib/mongo-java-driver-2.7.3.jar":
    ensure => link,
    target => "/usr/share/java/mongo-java-driver-2.7.3.jar",
    require => File["mongo-java-driver"],
  }
  
  file { "mongo-hadoop-core":
    path => "/usr/share/hadoop/lib/mongo-hadoop-core_1.0.4-1.1.0.jar",
    ensure => file,
    source => "puppet:///modules/hadoop/mongo-hadoop-core_1.0.4-1.1.0.jar",
    owner => "root",
    group => "root",
    mode => 644,
  }
  
  file { "/usr/lib/hadoop/lib/mongo-hadoop-core_1.0.4-1.1.0.jar":
    ensure => link,
    target => "/usr/share/hadoop/lib/mongo-hadoop-core_1.0.4-1.1.0.jar",
    require => File["mongo-hadoop-core"],
  }
  
  file { "/etc/sysctl.d/60-reboot":
    ensure => file,
    content => "kernel.panic=10",
  }
  
  file { "/etc/sysctl.d/60-swappyness":
    ensure => file,
    content => "vm/swappiness=0",
  }
  
}

class hadoop::package {
  
  require hadoop::apt
  
  package { "hadoop":
    ensure => "present",
  }
  
}

class hadoop::apt {
  
  apt::source { "hadoop_precise":
    location => "http://ppa.launchpad.net/hadoop-ubuntu/stable/ubuntu",
    release => "precise",
    repos => "main",
    key => "84FBAFF0",
    key_server => "keyserver.ubuntu.com",
    include_src => true,
  }

}
