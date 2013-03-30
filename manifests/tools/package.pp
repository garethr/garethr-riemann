class riemann::tools::package(
  $ensure = 'installed'
) {
  ensure_packages($riemann::tools::params::packages)
  package { [
      'riemann-client',
      'riemann-tools',
    ]:
    ensure   => $ensure,
    provider => gem,
  }
}