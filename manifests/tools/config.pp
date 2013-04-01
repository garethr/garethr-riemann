class riemann::tools::config {
  $health_enabled = $riemann::tools::health_enabled
  $net_enabled = $riemann::tools::net_enabled

  case $::osfamily {
    'Debian': {
      file { '/etc/init.d/riemann-health':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/riemann-health.conf':
        ensure => present,
        source => 'puppet:///modules/riemann/etc/init/riemann-health.conf',
      }

      file { '/etc/init.d/riemann-net':
        ensure => link,
        target => '/lib/init/upstart-job',
      }

      file { '/etc/init/riemann-net.conf':
        ensure => present,
        source => 'puppet:///modules/riemann/etc/init/riemann-net.conf',
      }
    }
    'RedHat', 'Amazon': {
      file { '/etc/init.d/riemann-net':
        ensure => present,
        source => 'puppet:///modules/riemann/etc/init/riemann-net.conf.redhat',
        group  => root,
        owner  => root,
        mode   => '0755',
      }

      file { '/etc/init.d/riemann-health':
        ensure => present,
        source => 'puppet:///modules/riemann/etc/init/riemann-health.conf.redhat',
        group  => root,
        owner  => root,
        mode   => '0755',
      }
    }
  }

}
