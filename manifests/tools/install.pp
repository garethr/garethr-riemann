class riemann::tools::install {
  package { [
      'riemann-client',
      'riemann-tools',
    ]:
      ensure   => installed,
      provider => gem,
  }
}
