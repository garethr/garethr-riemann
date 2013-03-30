# Use for bootstrapping the dashboard configuration file,
# with useful parameters. Ensures there's a
# '/etc/riemann-dash.rb' file afterwards.
#
# Assumes Service['riemann-dash'].
#
# Parameters
# - filename: introduces File[$filename]
# - bind: the bind address, e.g. 'localhost' or '0.0.0.0'.
# - config_file: mutually exclusive with config_file_template,
#      Specifies location of configuration file.
# - config_file_template: path to be accepted by template/1.
class riemann::dash::config(
  $bind                 = 'localhost',
  $filename             = '/etc/riemann-dash.rb',
  $config_file          = '',
  $config_file_template = 'riemann/riemann-dash.rb.erb'
) {
  $manage_source = $config_file ? {
    ''      => undef,
    default => $config_file,
  }

  $manage_content = $config_file ? {
    ''      => template($config_file_template),
    default => undef,
  }

  anchor { 'riemann::dash::config': } ->

  file { $filename:
    ensure  => present,
    source  => $manage_source,
    content => $manage_content,
    notify  => Service['riemann-dash'],
  } ->

  anchor { 'riemann::dash::config': }
}