class riemann::tools::package(
  $ensure = 'installed'
) {
  package { [
      'riemann-client',
      'riemann-tools',
    ]:
    ensure   => $ensure,
    provider => gem,
  }
}