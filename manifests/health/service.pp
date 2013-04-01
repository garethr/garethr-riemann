class riemann::health::service(
  $ensure = 'running',
  $enable = true
) {
  $config_file = $riemann::health::config_file
  $config_file_template = $riemann::health::config_file_template
  $log_dir = $riemann::health::log_dir

  $manage_health_config_file = $config_file ? {
    ''      => 'puppet:///modules/riemann/riemann-health.conf',
    default => $config_file,
  }

  riemann::utils::mixsvc { 'riemann-health':
    config_file => $manage_health_config_file,
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $enable,
    exec        => '/usr/bin/riemann-health',
    description => 'Riemann Health Process',
    grep        => 'grep riemann-health | grep ruby',
  }
}