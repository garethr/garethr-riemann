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

  anchor { 'riemann::start': }

  group { $group:
    ensure  => present,
    system  => true,
    require => Anchor['riemann::start'],
    before  => Anchor['riemann::end'],
  }

  ensure_packages($riemann::params::tools_packages)

  @package { 'riemann-tools':
    ensure   => 'installed',
    provider => gem,
    require  => Package[$riemann::params::tools_packages],
  }

  class { 'riemann::package':
    require => Anchor['riemann::start'],
    before  => Anchor['riemann::end'],
  } ->
  class { 'riemann::config':
    require => Anchor['riemann::start'],
    before  => Anchor['riemann::end'],
  } ~>
  class { 'riemann::service':
    require => Anchor['riemann::start'],
    before  => Anchor['riemann::end']
  }

  anchor { 'riemann::end': }
}