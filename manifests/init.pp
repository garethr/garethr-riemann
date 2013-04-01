# Parameters
# - config_file: the clojure configuration file for riemann,
#   not an upstart script or dash config. This should be a 'source' path
class riemann(
  $version     = $riemann::params::version,
  $config_file = $riemann::params::config_file,
  $host        = $riemann::params::host,
  $port        = $riemann::params::port,
  $dir         = $riemann::params::dir,
  $bin_dir     = $riemann::params::bin_dir,
  $log_dir     = $riemann::params::log_dir,
  $group       = $riemann::params::group,
  $user        = $riemann::params::user
) inherits riemann::params {
  validate_string($version, $host, $port)

  @group { $group:
    ensure => present,
    system => true,
  }

  @package { 'riemann-tools':
    ensure   => 'installed',
    provider => gem,
    require  => $riemann::params::tools_packages,
  }

  class { 'riemann::package': } ->
  class { 'riemann::config': } ~>
  class { 'riemann::service': } ->
  Class['riemann']
}