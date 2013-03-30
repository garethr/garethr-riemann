# create a debian, rhel service with infra:
# - user for svc
# - group for svc
# - upstart for debian
# - initv for rhel (currently)
# - log dir
# - exec: binary to execute
define riemann::utils::mixsvc(
  $ensure               = 'running',
  $enable               = true,
  $config_file          = '',
  $config_file_template = '',
  $user                 = '',
  $group                = '',
  $grep                 = undef,
  $home                 = undef,
  $log_dir,
  $exec,
  $description
) {
  $service_provider = $::osfamily ? {
    'Amazon' => 'redhat',
    'RedHat' => 'redhat',
    'Debian' => 'upstart',
    default  => 'upstart'
  }

  $manage_user = $user ? {
    ''      => $title,
    undef   => $title,
    default => $user,
  }

  $manage_group = $group ? {
    ''      => $title,
    undef   => $title,
    default => $group,
  }

  group { $group:
    ensure  => present,
    system  => true
  }

  user { $user:
    ensure  => present,
    system  => true,
    gid     => $group,
    home    => $home,
    shell   => '/bin/bash',
    require => Group[$group], 
  }

  case $::osfamily {
    'Debian': {
      riemann::utils::upconf { $title:
        user        => $user,
        description => $description,
        exec        => $exec,
        file        => $config_file,
        template    => $config_file_template,
      }
    }
    'RedHat': {
      riemann::utils::initvconf { $title:
        user        => $user,
        description => $description,
        exec        => $exec,
        log_dir     => $log_dir,
        grep        => $grep,
        file        => $config_file,
        template    => $config_file_template,
      }
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