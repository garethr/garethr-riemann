class riemann::dash::service(
  $dash_config_file = ''
) {
  file { '/etc/init.d/riemann-dash':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/riemann-dash.conf':
    ensure  => present,
    content => template('riemann/riemann-dash.conf.erb'),
    notify  => Service['riemann-dash'],
  }

  service {'riemann-dash':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => upstart,
    require    => [
      File['/etc/init/riemann-dash.conf'],
      File['/etc/init.d/riemann-dash'],
    ]
  }
}