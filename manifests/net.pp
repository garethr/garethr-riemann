class riemann::net(
  $enable  = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::net::params::log_dir
) inherits riemann::net::params {
  class { 'riemann::net::package': } ->
  class { 'riemann::net::config': } ~>
  class { 'riemann::net::service': } ->
  Class['riemann::net']
}