# Use for bootstrapping the dashboard configuration file,
# with useful parameters. Ensures there's a
# '/etc/riemann-dash.rb' file afterwards.
#
class riemann::dash::config {
  $config_file = $riemann::dash::config_file
  $config_file_template = $riemann::dash::config_file_template
  $host        = $riemann::dash::host
  $port        = $riemann::dash::port

  $manage_source = $config_file ? {
    ''      => undef,
    undef   => undef,
    default => $config_file,
  }

  $manage_content = $config_file ? {
    ''      => template($config_file_template),
    undef   => template($config_file_template),
    default => undef,
  }

  file { '/etc/riemann-dash.rb':
    ensure  => present,
    source  => $manage_source,
    content => $manage_content,
  }
}