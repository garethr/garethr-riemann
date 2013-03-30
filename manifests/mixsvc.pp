define riemann::mixsvc(
  $ensure               = 'running',
  $enable               = true,
  $config_file          = '',
  $config_file_template = '',
  $log_dir,
) {
  $service_provider = $::osfamily ? {
    'Amazon' => 'redhat',
    'RedHat' => 'redhat',
    'Debian' => 'upstart',
    default  => 'upstart'
  }
  # content should be set to a default if no file
  $manage_config_content = $config_file ? {
    ''      => template($config_file_template),
    undef   => template($config_file_template),
    default => undef,
  }

  # source should be set if we have a config file
  $manage_config_source = $config_file ? {
    ''      => undef,
    undef   => undef,
    default => $config_file
  }

  case $::osfamily {
    'Debian': {
      Service[$title] { require +> File['/etc/init/$title.conf'] }

      file { '/etc/init.d/$title':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/$title.conf':
        ensure  => present,
        source  => $manage_config_source,
        content => $manage_config_content,
      }

      File['/etc/init/$title.conf'] ~> Service[$title]
    }
    'RedHat': {
      file { '/etc/init.d/$title':
        ensure  => present,
        mode    => '0755',
        source  => $manage_config_source,
        content => $manage_config_content,
      }

      File['/etc/init.d/$title'] ~> Service[$title]
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }

  if (!defined($log_dir)) {
    file { $log_dir:
      ensure => 'directory',
      mode   => '0755',
    }
  }

  service { $title:
    ensure     => $ensure,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => $service_provider,
    require    => [
      File['/etc/init.d/$title']
    ],
  }
}