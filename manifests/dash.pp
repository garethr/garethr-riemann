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
) {
  class { 'riemann::dash::package': } ->
  class { 'riemann::dash::config': } ~>
  class { 'riemann::dash::service': } ->
  Class['riemann::dash']
}