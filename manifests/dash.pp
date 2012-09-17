class riemann::dash($config_file='') {
  include riemann::dash::params
  include riemann::dash::package
  class {'riemann::dash::service': dash_config_file => $config_file }
}
