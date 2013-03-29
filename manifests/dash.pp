class riemann::dash(
  $host = $riemann::params::dash_host,
  $port = $riemann::params::dash_port,
){
  validate_string($host)
  class { 'riemann::dash::install': } ->
  class { 'riemann::dash::config': } ~>
  class { 'riemann::dash::service': } ->
  Class['riemann::dash']
}
