class riemann::tools::config {
  $health_enabled = $riemann::tools::health_enabled
  $net_enabled = $riemann::tools::net_enabled

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
