class riemann::tools(
  $health_enabled = true,
  $net_enabled    = true
) {
  include riemann::tools::package

  anchor { 'riemann::tools::start': } ->

  class { 'riemann::tools::service':
    health_enabled => $health_enabled,
    net_enabled    => $net_enabled,
  } ->

  anchor { 'riemann::tools::end': }
}