class riemann::service($config_file) {

  # Common dependencies for the service. We'll add OS specific
  # dependencies below.
  $service_dependencies = [ File['/etc/init.d/riemann'],
                            Class['riemann::package'], ]

  case $::osfamily {
    'Debian': {

      $service_provider = 'upstart'
      $service_dependencies += [ File['/etc/init/riemann.conf'] ]

      file { '/etc/init.d/riemann':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/riemann.conf':
        ensure  => present,
        content => template('riemann/init/riemann.debian.erb')
      }

      File['/etc/init/riemann.conf'] ~> Service['riemann']
    }

    'RedHat': {

      $service_provider = 'redhat'

      file { '/etc/init.d/riemann':
        ensure  => present,
        mode    => '0755',
        content => template('riemann/init/riemann.redhat.erb'),
      }
    }

    default: {
      err("$::operatingsystem not supported")
    }
  }

  file {'/var/log/riemann':
    ensure => 'directory',
    mode   => '0755',
  }

  service {'riemann':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => $service_provider,
    require    => $service_dependencies,
  }

}
