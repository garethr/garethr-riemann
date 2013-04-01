# Includes Package['riemann-dash'].
#
# Parameters:
#   config_file: the path to the configuration file
#     to use for parameters for the dashboard. It is a
#     Sinatra web configuration file. Defaults to a sane
#     default if left empty.
class riemann::dash(
  $config_file          = '',
  $config_file_template = 'riemann/riemann-dash.rb.erb',
  $host        = $riemann::dash::params::host,
  $port        = $riemann::dash::params::port,
  $log_dir     = $riemann::dash::params::log_dir
) inherits riemann::dash::params {
  anchor { 'riemann::dash::start': }

  class { 'riemann::dash::package':
    require => Anchor['riemann::dash::start'],
    before  => Anchor['riemann::dash::end'],
  } ->
  class { 'riemann::dash::config':
    require => Anchor['riemann::dash::start'],
    before  => Anchor['riemann::dash::end'],
  } ~>
  class { 'riemann::dash::service':
    require => Anchor['riemann::dash::start'],
    before  => Anchor['riemann::dash::end'],
  }

  anchor { 'riemann::dash::end': }
}