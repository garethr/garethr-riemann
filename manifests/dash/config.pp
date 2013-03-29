# Use for bootstrapping the dashboard configuration file,
# with useful parameters. Ensures there's a
# '/etc/riemann-dash.rb' file afterwards.
#
# Assumes Service['riemann-dash'].
#
# Parameters
#   file: the filename that exists afterwards.
#   bind: the bind address, e.g. 'localhost' or '0.0.0.0'.
#
class riemann::dash::config(
  $bind = 'localhost',
  $file = '/etc/riemann-dash.rb',
) {
  anchor { 'riemann::dash::config': } ->

  file { $file:
    ensure  => present,
    source  => template('riemann/riemann-dash.rb.erb'),
    notify  => Service['riemann-dash'],
  } ->

  anchor { 'riemann::dash::config': }
}