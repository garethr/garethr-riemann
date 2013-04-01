class riemann::health(
  $enable = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::health::params::log_dir
) inherits riemann::health::params {
  anchor { 'riemann::health::start': }

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