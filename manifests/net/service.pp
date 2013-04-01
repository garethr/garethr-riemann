# Gathers munin statistics and submits them to Riemann.
class riemann::net::service(
  $ensure = 'running',
  $enable = true
) {
  $log_dir = $riemann::net::log_dir
  $group   = $riemann::group

  riemann::utils::mixsvc { 'riemann-net':
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $enable,
    exec        => '/usr/bin/riemann-net',
    args        => '',
    description => 'Riemann Net Process',
    group       => $group,
  }
}