class riemann::dash::package {
  include gcc
  package { [
      'riemann-dash'
    ]:
      ensure   => installed,
      require  => Class['gcc'],
      provider => gem,
  }
}