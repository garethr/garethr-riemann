class riemann::package($version) inherits riemann::params {
  include wget

  package { $packages:
      ensure => installed,
  }

  wget::fetch { 'download_riemann':
    source      => "http://aphyr.com/riemann/riemann-$version.tar.bz2",
    destination => "/usr/local/src/riemann-$version.tar.bz2",
    before      => Exec['untar_riemann'],
  }

  exec { 'untar_riemann':
    command => "tar xvfj /usr/local/src/riemann-$version.tar.bz2",
    creates => "/opt/riemann-$version",
    cwd     => '/opt',
    path    => ['/bin', '/usr/bin',],
    before  => File['/opt/riemann'],
  }

  file { '/opt/riemann':
    ensure => link,
    target => "/opt/riemann-$version",
    notify => Service['riemann'],
  }

}
