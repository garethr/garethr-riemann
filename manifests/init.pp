class riemann(
  $version = $riemann::params::version,
  $config_file = $riemann::params::config_file,
  $host = $riemann::params::host,
  $port = $riemann::params::port,
) inherits riemann::params {

  validate_absolute_path($config_file)
  validate_string($version, $host, $port)

  class { 'riemann::install': } ->
  class { 'riemann::config': } ~>
  class { 'riemann::service': } ->
  Class['riemann']
}
