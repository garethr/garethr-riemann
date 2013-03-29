class riemann::config {

  $host = $riemann::host
  $port = $riemann::port

  file { '/etc/riemann.sample.config':
    ensure => present,
    source => 'puppet:///modules/riemann/riemann.config',
    notify => Service['riemann']
  }

  file { '/etc/puppet/riemann.yaml':
    ensure  => present,
    content => template('riemann/puppet/riemann.yaml.erb')
  }
}
