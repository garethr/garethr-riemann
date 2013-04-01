class riemann::health::service(
  $ensure = 'running',
  $enable = true
) {
  $log_dir = $riemann::health::log_dir
  $group   = $riemann::group

  riemann::utils::mixsvc { 'riemann-health':
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $enable,
    exec        => '/usr/bin/riemann-health',
    args        => '',
    description => 'Riemann Health Process',
    group       => $group,
  }
}