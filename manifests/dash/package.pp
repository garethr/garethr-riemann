# Installs the dashboard ruby gem.
class riemann::dash::package(
  $ensure = 'installed'
) inherits riemann::params {
  ensure_packages($riemann::params::tools_packages)

  package { 'riemann-dash':
    ensure   => $ensure,
    require  => Package[$riemann::params::tools_packages],
    provider => gem,
  }
}