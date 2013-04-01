class riemann::net(
  $enable               = true,
  $config_file          = '',
  $config_file_template = '',
  $log_dir              = $riemann::params::log_dir
) inherits riemann::params {
  $user = $riemann::params::net_user

  anchor { 'riemann::net::start': }

  riemann::utils::stduser { $user:
    group => $group,
    require => Anchor['riemann::net::start'],
    before  => Anchor['riemann::net::end'],
  } ->
  class { 'riemann::net::package':
    require => Anchor['riemann::net::start'],
    before  => Anchor['riemann::net::end'],
  } ->
  class { 'riemann::net::config':
    require => Anchor['riemann::net::start'],
    before  => Anchor['riemann::net::end'],
  } ~>
  class { 'riemann::net::service':
    require => Anchor['riemann::net::start'],
    before  => Anchor['riemann::net::end'],
  }

  anchor { 'riemann::net::end': }
}