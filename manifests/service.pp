class riemann::service(
  $config_file = '',
  $riemann_bin_dir = $riemann::params::bin_dir
) {
  # content should be set to a default if no file
  $manage_config_content = $config_file ? {
    ''      => template('riemann/init/riemann.conf.erb'),
    undef   => template('riemann/init/riemann.conf.erb'),
    default => undef,
  }

  # source should be set if we have a config file
  $manage_config_source = $config_file ? {
    ''      => undef,
    undef   => undef,
    default => $config_file
  }

  file { '/etc/init.d/riemann':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/riemann.conf':
    ensure  => present,
    source  => $manage_config_source,
    content => $manage_config_content,
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