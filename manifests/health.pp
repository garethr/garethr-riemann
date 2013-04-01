class riemann::health(
  $enable = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::health::params::log_dir
) inherits riemann::health::params {
  class { 'riemann::health::package': } ->
  class { 'riemann::health::config': } ~>
  class { 'riemann::health::service': } ->
  Class['riemann::health']
}