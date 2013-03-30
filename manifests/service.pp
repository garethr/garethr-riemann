class riemann::service(
  $config_file = '',
  $bin_dir = $riemann::params::bin_dir,
  $log_dir = $riemann::params::log_dir
) {
  riemann::mixsvc { 'riemann':
    log_dir              => $log_dir,
    config_file          => $config_file,
    config_file_template => $riemann::params::service_config_template
  }
}