class riemann::dash::install {
  include gcc

  package { [
      'riemann-dash'
    ]:
      ensure   => installed,
      require  => Class['gcc'],
      provider => gem,
  }
}
