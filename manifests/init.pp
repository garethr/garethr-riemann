class riemann(
  $version     = $riemann::params::version,
  $config_file = $riemann::params::config_file
) inherits riemann::params {
  class { 'riemann::package':
    version => $version,
  }
  include riemann::config
  class { 'riemann::service':
    config_file => $config_file,
  }
}