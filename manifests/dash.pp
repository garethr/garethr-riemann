# == Class: riemann::dash
#
# A module to manage the riemann dashboard,
# a monitoring system for distributed systems
#
# === Parameters
#
# [*host*]
#   Host for the riemann dashboard. Defaults to localhost
#
# [*port*]
#   Port for the riemann server. Defaults to 4567
#
# [*user*]
#   The system user which riemann-dash runs as. Defaults to riemann-dash.
#   Will be created by the module.
#
# [*rvm_ruby_string*]
#   The RVM Ruby version which should be used. Defaults to undef.
#
class riemann::dash(
  $host = $riemann::params::dash_host,
  $port = $riemann::params::dash_port,
  $user = $riemann::params::dash_user,
  $s3_config = $riemann::params::dash_s3_config,
  $ws_config = $riemann::params::dash_ws_config,
  $rvm_ruby_string = $riemann::params::rvm_ruby_string,
) inherits riemann::params {
  validate_string($host)
  validate_string($user)
  class { 'riemann::dash::install': } ->
  class { 'riemann::dash::config': } ~>
  class { 'riemann::dash::service': } ->
  Class['riemann::dash']
}
