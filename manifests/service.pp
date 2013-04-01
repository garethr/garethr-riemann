class riemann::service(
  $ensure = 'running',
  $enable = true
) {
  $log_dir = $riemann::log_dir
  $bin_dir = $riemann::bin_dir
  $user    = $riemann::user
  $group   = $riemann::group

  riemann::utils::mixsvc { 'riemann':
    ensure      => $ensure,
    enable      => $enable,
    user        => $user,
    group       => $group,
    log_dir     => $log_dir,
    exec        => "${bin_dir}/riemann",
    description => 'Riemann Server',
  }
}