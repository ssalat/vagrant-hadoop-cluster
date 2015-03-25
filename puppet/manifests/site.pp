notice("Building environment [${environment}] for node [${hostname}] ...")

$application = "vagrant-hadoop-cluster"

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

group {
  "puppet": ensure => "present"
}

exec { "apt-get update": command => "apt-get update" }

class init {

  class { "apt":
    always_apt_update => false,
    purge_sources_list => true,
    purge_sources_list_d => true,
  }

  apt::source { "ubuntu_precise":
    location => "http://us.archive.ubuntu.com/ubuntu/",
    release => "precise",
    repos => "main restricted universe multiverse",
    include_src => false,
  }

  apt::source { "ubuntu_precise_updates":
    location => "http://us.archive.ubuntu.com/ubuntu/",
    release => "precise-updates",
    repos => "main restricted universe multiverse",
    include_src => false,
  }

  apt::source { "ubuntu_precise_security":
    location => "http://us.archive.ubuntu.com/ubuntu/",
    release => "precise-security",
    repos => "main restricted universe multiverse",
    include_src => false,
  }

  apt::source { "ubuntu_precise_backports":
    location => "http://us.archive.ubuntu.com/ubuntu/",
    release => "precise-backports",
    repos => "main restricted universe multiverse",
    include_src => false,
  }

  Exec["apt-get update"] -> Package <| |>

}

require init

import "nodes"
