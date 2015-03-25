class base {
  
  include avahi
  
  package { "openjdk-6-jdk" :
    ensure => "present",
    require => Exec['apt-get update']
  }
  
  file { "/root/.ssh":
    ensure => "directory",
  }

  file { "/root/.ssh/config":
    source => "puppet:///modules/base/ssh_config",
    mode => 600,
    owner => "root",
    group => "root",
  }

  file { "/root/.ssh/id_rsa":
      source => "puppet:///modules/base/id_rsa",
      mode => 600,
      owner => "root",
      group => "root",
  }

  file { "/root/.ssh/id_rsa.pub":
      source => "puppet:///modules/base/id_rsa.pub",
      mode => 644,
      owner => "root",
      group => "root",
  }

  ssh_authorized_key { "ssh_key":
    ensure => "present",
    key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCrE3YeyXmvXX3eqUqrOBCFDsnPTNW5AVrfZRJwDuAeF3l7ZJKlc8lznxBgUXKesa4OcRQmgJOQqiXr7RRc6Hn8xHzAvm1O8SQi3Is3l3QzQemmvTHcJ5lLL/yLnX/4qAZptFP3gvHQfxVLC751Qbzvh1b/hVk1ZeQbLlGKt8FPyGXrAnQ/cXxwPgPnGa+p5CP23ikw3bKrzkKYtkZWicfn1k4IPB0Jc4BcFHEts1+qZqWhpWSWhf59MeEkcCyQuC9ICsRKgXQ8jLB5gIm7yHn8MUNc0HsZmZr+etVGwUyW6wGYSitPqss0FUzEiarq+w+slCk6TGSVyRQ6sVCnS3NV",
    type => "ssh-rsa",
    user => "root",
    require => File["/root/.ssh/id_rsa.pub"]
  }
  
  file { "/etc/motd":
    source => "puppet:///modules/base/motd",
    mode => 644,
  }

}
