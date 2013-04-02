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
      $gem_path = $riemann::params::gem_path
      file { '/etc/init.d/riemann-net':
        ensure  => present,
        content => template('riemann/etc/init/riemann-net.conf.redhat.erb'),
        group   => root,
        owner   => root,
        mode    => '0755',
      }

      file { '/etc/init.d/riemann-health':
        ensure  => present,
        content => template('riemann/etc/init/riemann-health.conf.redhat.erb'),
        group   => root,
        owner   => root,
        mode    => '0755',
      }
    }
  }

}
