# Installs the dashboard ruby gem.
class riemann::dash::package(
  $ensure = 'installed'
) inherits riemann::params {
  package { 'riemann-dash':
    ensure   => $ensure,
    provider => gem,
  }
}