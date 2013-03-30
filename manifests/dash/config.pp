class riemann::dash::config {
  $host = $riemann::dash::host
  $port = $riemann::dash::port

  file { '/etc/init.d/riemann-dash':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/riemann-dash.conf':
    ensure  => present,
    content => template('riemann/etc/init/riemann-dash.conf.erb'),
  }

  file { '/etc/riemann-dash.rb':
    ensure => present,
    content => template('riemann/etc/riemann-dash.rb.erb'),
  }
}
