# Installs the riemann-dash service.
class riemann::dash::service(
  $config_file = '',
  $log_dir     = $riemann::dash::params::log_dir
) {
  riemann::utils::mixsvc { 'riemann-dash':
    log_dir              => $log_dir,
    config_file          => $config_file,
    config_file_template => $riemann::dash::params::dash_config_template,
    exec                 => '/usr/bin/riemann-dash',
    description          => 'A service that launches the riemann dashboard',
    grep                 => 'grep riemann-dash | grep ruby',
  }
}