# == Class: riemann::tools
#
# A module to manage the riemann tools provided by the tools gem,
# includes services for net and health at present
#
# === Parameters
#
# [*health_enabled*]
#   Whether to start the riemann health daemon to collect system stats
#   defaults to true
#
# [*net_enabled*]
#   Whether to start the riemann health daemon to collect system stats
#   defaults to true
#
# [*health_user*]
#   The system user which riemann-health runs as. Defaults to riemann-health.
#   Will be created by the module.
#
# [*net_user*]
#   The system user which riemann-net runs as. Defaults to riemann-net.
#   Will be created by the module.
#
# [*rvm_ruby_string*]
#   The RVM Ruby version which should be used. Defaults to undef.
#
class riemann::tools(
  $health_enabled = true,
  $health_user = $riemann::params::health_user,
  $net_enabled = true,
  $net_user = $riemann::params::net_user,
  $rvm_ruby_string = $riemann::params::rvm_ruby_string,
) inherits riemann::params {
  validate_bool($health_enabled, $net_enabled)
  class { 'riemann::tools::install': } ->
  class { 'riemann::tools::config': } ~>
  class { 'riemann::tools::service': } ->
  Class['riemann::tools']
}
