define riemann::utils::initvconf(
  $enable      = 'present',
  $file        = '',
  $template    = 'riemann/initv.conf.erb',
  $user        = undef,
  $description = undef,
  $grep        = "grep $title",
  $log_dir     = "/var/log/$title",
  $args        = '',
  $exec
) {
  # content should be set to a default if no file
  $manage_config_content = $file ? {
    ''      => template($template),
    undef   => template($template),
    default => undef,
  }

  # source should be set if we have a config file
  $manage_config_source = $file ? {
    ''      => undef,
    undef   => undef,
    default => $file,
  }

  file { '/etc/init.d/$title':
    ensure  => present,
    mode    => '0755',
    source  => $manage_config_source,
    content => $manage_config_content,
  }

  File['/etc/init.d/$title'] ~> Service[$title] 
}