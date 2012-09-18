class riemann::dash::service($dash_config_file='')
  inherits riemann::dash::params {

  case $::osfamily {
    'Debian': {

      $service_dependencies += [ File['/etc/init/riemann-dash.conf']]

      file { '/etc/init.d/riemann-dash':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/riemann-dash.conf':
        ensure  => present,
        content => template('riemann/init/riemann-dash.debian.erb'),
        notify  => Service['riemann-dash'],
      }
    }

    'RedHat': {

      file { '/etc/init.d/riemann-dash':
        ensure  => present,
        mode    => '0755',
        content => template('riemann/init/riemann-dash.redhat.erb'),
      }

    }

    default: {
      err("$::operatingsystem not supported")
    }
  }

  service {'riemann-dash':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => $service_provider,
    require    => $service_dependencies
  }
}
