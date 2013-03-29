class riemann::dash::config {
  $host = $riemann::dash::host
  $port = $riemann::dash::port
  file { '/etc/riemann-dash.rb':
    ensure => present,
    content => template('riemann/etc/riemann-dash.rb.erb'),
  }
}
