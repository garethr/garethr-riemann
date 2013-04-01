# Installs the riemann-dash service.
class riemann::dash::service(
  $ensure = 'running',
  $enable = true
) {
  $log_dir = $riemann::dash::log_dir
  $group   = $riemann::group

  riemann::utils::mixsvc { 'riemann-dash':
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $enable,
    exec        => '/usr/bin/riemann-dash',
    description => 'A service that launches the riemann dashboard',
    grep        => 'grep riemann-dash | grep ruby',
    group       => $group,
  }
}