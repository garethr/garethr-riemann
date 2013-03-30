class riemann::tools(
  $health_enabled = true,
  $net_enabled    = true
) {

  anchor { 'riemann::tools::start': } ->

  class { 'riemann::tools::package': } ->

  class { 'riemann::tools::service':
    health_enable => $health_enabled,
    net_enable    => $net_enabled,
  } ->

  anchor { 'riemann::tools::end': }
}