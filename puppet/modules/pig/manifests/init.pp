
class pig {
  
  require pig::base
  
}

class pig::base {
  
  require pig::package
  
  file { "mongo-hadoop-pig":
    path => "/usr/share/pig/lib/mongo-hadoop-pig_1.0.4-1.1.0.jar",
    ensure => file,
    source => "puppet:///modules/pig/mongo-hadoop-pig_1.0.4-1.1.0.jar",
    owner => "root",
    group => "root",
    mode => 644,
  }
  
}

class pig::package {
  
  require hadoop::package
  
  package { [ "pig" ]:
    ensure => "latest",
    require => Exec["apt-get update"],
  }
  
}
