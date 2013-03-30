# Installs the riemann-dash service.
class riemann::dash::service(
  $config_file = '',
  $log_dir     = $riemann::dash::params::log_dir
) {
  riemann::mixsvc { 'riemann-dash':
    log_dir              => $log_dir,
    config_file          => $config_file,
    config_file_template => $riemann::dash::params::dash_config_template
  }
}