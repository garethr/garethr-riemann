# Installs the riemann-dash service.
class riemann::dash::service(
  $ensure = 'running',
  $enable = true
) {
  $log_dir     = $riemann::dash::log_dir
  $group       = $riemann::group
  $config_file = $riemann::dash::config_file
  $home        = $riemann::dash::home

  riemann::utils::mixsvc { 'riemann-dash':
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $enable,
    exec        => '/usr/bin/riemann-dash',
    args        => $config_file,
    description => 'A service that launches the riemann dashboard',
    group       => $group,
    home        => $home,
  }
}