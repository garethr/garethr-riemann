# User-per-service, multiple users in group,
# group-per-puppetmodule.
#
# create a debian, rhel service with infra:
# - user for svc
# - group for svc
# - upstart for debian
# - initv for rhel (currently)
# - exec: binary to execute
define riemann::utils::mixsvc(
  $ensure               = 'running',
  $enable               = true,
  $config_file          = undef,
  $config_file_template = undef,
  $user                 = '',
  $group                = '',
  $home                 = undef,
  $respawn              = true,
  $log_dir,
  $exec,
  $args,
  $description
) {
  $service_provider = $::osfamily ? {
    'Amazon' => 'redhat',
    'RedHat' => 'redhat',
    'Debian' => 'upstart',
    default  => 'upstart'
  }
  $manage_user = $name ? {
    ''      => $title,
    undef   => $title,
    default => $name,
  }

  case $::osfamily {
    'Debian': {
      riemann::utils::upconf { $title:
        user        => $manage_user,
        description => $description,
        exec        => $exec,
        args        => $args,
        file        => $config_file,
        template    => $config_file_template,
        respawn     => $respawn
      }
    }
    'RedHat': {
      riemann::utils::initvconf { $title:
        user        => $manage_user,
        description => $description,
        exec        => $exec,
        args        => $args,
        file        => $config_file,
        template    => $config_file_template,
      }
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }
  
  if ! defined(File[$log_dir]) {
    file { $log_dir:
      ensure => 'directory',
      mode   => '0755',
      owner  => 'root',
      group  => 'root',
    }
  }

  if ! defined(User[$manage_user]) {
    user { $manage_user:
      ensure  => present,
      system  => true,
      gid     => $group,
      home    => $home,
      shell   => '/bin/bash',
    }
  }

  service { $title:
    ensure     => $ensure,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => $service_provider,
    require    => File["/etc/init.d/$title"],
  }
}