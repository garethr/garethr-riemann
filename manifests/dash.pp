class riemann::dash {
  class { 'riemann::dash::install': } ->
  class { 'riemann::dash::service': }
}
