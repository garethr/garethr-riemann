class riemann::config {
  $host = $riemann::host
  $port = $riemann::port
  $config = $riemann::config_file

  file { '/etc/riemann.config':
    ensure => present,
    source => $config,
  }

  file { '/etc/puppet/riemann.yaml':
    ensure  => present,
    content => template('riemann/puppet/riemann.yaml.erb'),
  }
}