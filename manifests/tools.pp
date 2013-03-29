class riemann::tools(
  $health_enabled = true,
  $net_enabled = true,
){
  validate_bool($health_enabled, $net_enabled)
  class { 'riemann::tools::install': } ->
  class { 'riemann::tools::config': } ~>
  class { 'riemann::tools::service': } ->
  Class['riemann::tools']
}
