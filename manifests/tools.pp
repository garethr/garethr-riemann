class riemann::tools($health_enabled=true, $net_enabled=true) {
  class { 'riemann::tools::install': } ->
  class { 'riemann::tools::service':
    health_enabled => $health_enabled,
    net_enabled    => $net_enabled,
  }
}
