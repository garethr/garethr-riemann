class riemann::dash::package {

  riemann::dash::ensure_packages{$riemann::dash::params::packages:}

  package { [
      'riemann-dash'
    ]:
      ensure   => installed,
      require  => Package[$riemann::dash::params::packages],
      provider => gem,
  }
}
