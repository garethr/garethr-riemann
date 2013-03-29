# Includes Package['riemann-dash'].
#
# Parameters:
#   config_file: the path to the configuration file
#     to use for parameters for the dashboard. It is a
#     Sinatra web configuration file. Defaults to a sane
#     default if left empty.
class riemann::dash(
  $config_file = ''
) {
  include riemann::dash::package
  class { 'riemann::dash::service':
    config_file => $config_file,
  }
}