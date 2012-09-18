class riemann::dash::package
  inherits riemann::dash::params {

  ensure_packages($packages)

  package { [
      'riemann-dash'
    ]:
      ensure   => installed,
      require  => Package[$packages],
      provider => gem,
  }
}
