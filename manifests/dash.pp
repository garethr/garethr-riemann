class riemann::dash(
  $host = $riemann::params::dash_host,
  $port = $riemann::params::dash_port,
) inherits riemann::params {
  validate_string($host)
  class { 'riemann::dash::install': } ->
  class { 'riemann::dash::config': } ~>
  class { 'riemann::dash::service': } ->
  Class['riemann::dash']
}
