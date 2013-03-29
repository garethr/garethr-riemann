class riemann::package(
  $version,
  $riemann_dir = $riemann::params::dir
) inherits riemann::params {
  include wget

  package { [
      'leiningen',
      'clojure1.3',
    ]:
    ensure => installed,
  }

  wget::fetch { 'download_riemann':
    source      => "http://aphyr.com/riemann/riemann-$version.tar.bz2",
    destination => "/usr/local/src/riemann-$version.tar.bz2",
    before      => Exec['untar_riemann'],
  }

  exec { 'untar_riemann':
    command => "tar xvfj /usr/local/src/riemann-$version.tar.bz2",
    cwd     => '/opt',
    creates => "/opt/riemann-$version",
    path    => ['/bin'],
    before  => File[$riemann_dir],
  }

  file { $riemann_dir:
    ensure => link,
    target => "/opt/riemann-$version",
    notify => Service['riemann'],
  }
}