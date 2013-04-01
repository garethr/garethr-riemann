class riemann::package {
  $version     = $riemann::version
  $riemann_dir = $riemann::dir

  ensure_packages($riemann::params::packages)

  class { 'wget': } ->

  wget::fetch { 'download_riemann':
    source      => "http://aphyr.com/riemann/riemann-$version.tar.bz2",
    destination => "/usr/local/src/riemann-$version.tar.bz2",
    before      => Exec['untar_riemann'],
  }

  exec { 'untar_riemann':
    command => "tar xvfj /usr/local/src/riemann-$version.tar.bz2",
    cwd     => '/opt',
    creates => "${riemann_dir}-$version",
    path    => ['/bin'],
    before  => File[$riemann_dir],
  }

  file { $riemann_dir:
    ensure => link,
    target => "${riemann_dir}-$version",
    notify => Service['riemann'],
  }
}