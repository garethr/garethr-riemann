class riemann::tools(
  $health_enabled=true,
  $net_enabled=true,
){
  class { 'riemann::tools::install': } ->
  class { 'riemann::tools::config': } ~>
  class { 'riemann::tools::service': } ->
  Class['riemann::tools']
}
