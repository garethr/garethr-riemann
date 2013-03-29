# Installs the dashboard ruby gem
class riemann::dash::package(
  $ensure = 'installed'
) {
  include gcc
  package { 'riemann-dash':
    ensure   => $ensure,
    require  => Class['gcc'],
    provider => gem,
  }
}