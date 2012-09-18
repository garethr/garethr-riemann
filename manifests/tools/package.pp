class riemann::tools::package inherits riemann::tools::params {

  ensure_packages($packages)

  package { [
      'riemann-client',
      'riemann-tools',
    ]:
      ensure   => installed,
      provider => gem,
  }
}
