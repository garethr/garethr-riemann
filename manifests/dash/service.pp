# Installs the riemann-dash service.
class riemann::dash::service(
  $config_file = ''
) {
  # content should be set to a default if no file
  $manage_config_content = $config_file ? {
    ''      => template('riemann/riemann-dash.conf.erb'),
    undef   => template('riemann/riemann-dash.conf.erb'),
    default => undef,
  }

  # source should be set if we have a config file
  $manage_config_source = $config_file ? {
    ''      => undef,
    undef   => undef,
    default => $config_file
  }

  file { '/etc/init.d/riemann-dash':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/riemann-dash.conf':
    ensure  => present,
    source  => $manage_config_source,
    content => $manage_config_content,
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