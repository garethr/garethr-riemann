class riemann(
  $version = $riemann::params::version,
  $config_file = $riemann::params::config_file
) inherits riemann::params {
  class { 'riemann::install': } ->
  class { 'riemann::config': } ~>
  class { 'riemann::service': } ->
  Class['riemann']
}
