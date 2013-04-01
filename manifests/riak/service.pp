class riemann::riak::service(
  $ensure = 'running',
  $enable = true
) {
  $log_dir = $riemann::riak::log_dir
  $group   = $riemann::group

  riemann::utils::mixsvc { 'riemann-riak':
    ensure      => $ensure,
    enable      => $ensure,
    exec        => '/usr/bin/riemann-riak',
    args        => '',
    description => 'Riemann Riak - Riak monitoring',
    group       => $group,
  }
}