class riemann::service(
  $config_file
) {
  file { '/etc/init.d/riemann':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/riemann.conf':
    ensure  => present,
    content => template('riemann/init/riemann.conf.erb'),
  }

  service {'riemann':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => upstart,
    require    => [
      File['/etc/init.d/riemann'],
      File['/etc/init/riemann.conf'],
      Class['riemann::package'],
    ],
  }

  File['/etc/init/riemann.conf'] ~> Service['riemann']
}