class riemann::health(
  $enable = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::params::log_dir
) inherits riemann::params {
  $user = $riemann::params::health_user

  anchor { 'riemann::health::start': }

  riemann::utils::stduser { $user:
    group => $group,
    require => Anchor['riemann::health::start'],
    before  => Anchor['riemann::health::end'],
  } ->
  class { 'riemann::health::package':
    require => Anchor['riemann::health::start'],
    before  => Anchor['riemann::health::end'],
  } ->
  class { 'riemann::health::config':
    require => Anchor['riemann::health::start'],
    before  => Anchor['riemann::health::end'],
  } ~>
  class { 'riemann::health::service':
    require => Anchor['riemann::health::start'],
    before  => Anchor['riemann::health::end'],
  }

  anchor { 'riemann::health::end': }
}