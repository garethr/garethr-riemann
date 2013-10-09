class riemann::install {
  include wget
  include java

  case $::osfamily {
    'Debian': {
      exec { 'riemann-apt-get-update':
        command     => '/usr/bin/apt-get update',
        before      => Class['java'],
      }
    }
    'RedHat', 'Amazon': {
      ensure_resource('package', 'daemonize', {'ensure' => 'present' })
    }
    default: {}
  }

  wget::fetch { 'download_riemann':
    source      => "http://aphyr.com/riemann/riemann-${riemann::version}.tar.bz2",
    destination => "/usr/local/src/riemann-${riemann::version}.tar.bz2",
    before      => Exec['untar_riemann'],
  }

  file { '/opt/riemann':
    ensure  => link,
    target  => "/opt/riemann-${riemann::version}",
    owner   => $riemann::user,
    require => User[$riemann::user],
  }

  user { $riemann::user:
    ensure => present,
  }

  file { "/opt/riemann-${riemann::version}":
    ensure  => directory,
    owner   => $riemann::user,
    require => User[$riemann::user],
  }

  exec { 'untar_riemann':
    command => "/bin/tar --bzip2 -xvf /usr/local/src/riemann-${riemann::version}.tar.bz2",
    cwd     => '/opt',
    creates => "/opt/riemann-${riemann::version}/bin/riemann",
    before  => File['/opt/riemann'],
    user    => $riemann::user,
    require => File["/opt/riemann-${riemann::version}"],
  }

}
