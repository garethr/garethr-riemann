class riemann::tools::service($health_enabled=true, $net_enabled=true) {

  $health_service_dependencies = [
      Service['riemann'],
      Class['riemann::tools::package'],
      File['/etc/init.d/riemann-health'],
  ]

  $net_service_dependencies = [
      Service['riemann'],
      Class['riemann::tools::package'],
      File['/etc/init.d/riemann-net'],
  ]

  case $::osfamily {
    'Debian': {

      $service_provider = 'upstart'
      $health_service_dependencies += [
        File['/etc/init/riemann-health.conf'], ]
      $net_service_dependencies += [
        File['/etc/init/riemann-net.conf'], ]

      file { '/etc/init.d/riemann-health':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/riemann-health.conf':
        ensure  => present,
        source  => 'puppet:///modules/riemann/init/riemann-health.debian.conf',
        notify  => Service['riemann-health'],
      }

      file { '/etc/init.d/riemann-net':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/riemann-net.conf':
        ensure  => present,
        source  => 'puppet:///modules/riemann/init/riemann-net.debian.conf',
        notify  => Service['riemann-net'],
      }
    }

    'RedHat': {
      $service_provider = 'redhat'

      file { '/etc/init.d/riemann-health':
        ensure => present,
        mode   => '0755',
        source => 'puppet:///modules/riemann/init/riemann-health.redhat.sh',
      }

      file { '/etc/init.d/riemann-net':
        ensure => present,
        mode   => '0755',
        source => 'puppet:///modules/riemann/init/riemann-net.redhat.sh',
      }
    }

    default: {
      err("$::operatingsystem not supported")
    }
  }


  service {'riemann-health':
    ensure     => running,
    enable     => $health_enabled,
    hasstatus  => true,
    hasrestart => true,
    provider   => $service_provider,
    require    => $health_service_dependencies,
  }


  service {'riemann-net':
    ensure     => running,
    enable     => $net_enabled,
    hasstatus  => true,
    hasrestart => true,
    provider   => $service_provider,
    require    => $net_service_dependencies,
  }

}
