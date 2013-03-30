# Installs the dashboard ruby gem.
class riemann::dash::package(
  $ensure = 'installed'
) inherits riemann::dash::params {
  ensure_packages($riemann::dash::params::packages)

  package { 'riemann-dash':
    ensure   => $ensure,
    require  => Package[$riemann::dash::params::packages],
    provider => gem,
  }
}