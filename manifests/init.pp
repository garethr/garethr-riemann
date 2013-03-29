class riemann(
  $version = $riemann::params::version,
  $config_file = $riemann::params::config_file,
  $host = $riemann::params::host,
  $port = $riemann::params::port,
) inherits riemann::params {
  class { 'riemann::install': } ->
  class { 'riemann::config': } ~>
  class { 'riemann::service': } ->
  Class['riemann']
}
