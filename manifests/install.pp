class riemann::install {
  include wget

  case $::osfamily {
    'Debian': {
      exec { 'riemann-apt-get-update':
        command     => '/usr/bin/apt-get update',
        before      => Class['java'],
      }
      include java
    }
    'RedHat', 'Amazon': {
      class { 'java':
        distribution => 'java-1.7.0-openjdk',
      }
    }
  }

  wget::fetch { 'download_riemann':
    source      => "http://aphyr.com/riemann/riemann-${riemann::version}.tar.bz2",
    destination => "/usr/local/src/riemann-${riemann::version}.tar.bz2",
    before      => Exec['untar_riemann'],
  }

  file { '/opt/riemann':
    ensure => link,
    target => "/opt/riemann-${riemann::version}",
  }

  exec { 'untar_riemann':
    command => "/bin/tar --bzip2 -xvf /usr/local/src/riemann-${riemann::version}.tar.bz2",
    cwd     => '/opt',
    creates => "/opt/riemann-${riemann::version}",
    before  => File['/opt/riemann'],
  }

}
