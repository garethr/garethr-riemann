class riemann::config {
  $host = $riemann::host
  $port = $riemann::port
  $config_file = $riemann::config_file

  file { '/etc/init.d/riemann':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/riemann.conf':
    ensure  => present,
    content => template('riemann/etc/init/riemann.conf.erb')
  }

  file { '/etc/riemann.sample.config':
    ensure => present,
    source => 'puppet:///modules/riemann/etc/riemann.config',
  }

  file { '/etc/puppet/riemann.yaml':
    ensure  => present,
    content => template('riemann/etc/puppet/riemann.yaml.erb')
  }
}
