class riemann::riak(
  $enable  = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::riak::params::log_dir
) inherits riemann::riak::params {
  class { 'riemann::riak::package': } ->
  class { 'riemann::riak::config': } ~>
  class { 'riemann::riak::service': } ->
  Class['riemann::riak']
}