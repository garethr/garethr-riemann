class riemann::tools::service(
  $health_enable      = true,
  $net_enable         = true,
  $ensure             = 'installed',
  $health_config_file = '',
  $net_config_file    = '',
  $log_dir            = $riemann::tools::params::log_dir
) {
  $manage_health_config_file = $health_config_file ? {
    '' => 'puppet:///modules/riemann/riemann-health.conf',
    default => $health_config_file
  }
  
  riemann::mixsvc { 'riemann-health':
    config_file => $manage_health_config_file,
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $health_enable,
  }

  $manage_net_config_file = $net_config_file ? {
    ''      => 'puppet:///modules/riemann/riemann-net.conf',
    default => $net_config_file,
  }

  riemann::mixsvc { 'riemann-net':
    config_file => $manage_net_config_file,
    log_dir     => $log_dir,
    ensure      => $ensure,
    enable      => $net_enable,
  }
}