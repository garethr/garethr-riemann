class riemann(
  $version     = $riemann::params::version,
  $config_file = $riemann::params::config_file
) inherits riemann::params {
  anchor { 'riemann::start': }

  class { 'riemann::package':
    version => $version,
    require => Anchor['riemann::start'],
    before  => Anchor['riemann::end'],
  } ->

  class { 'riemann::config':
    require => Anchor['riemann::start'],
    before  => Anchor['riemann::end'],
  } ->

  class { 'riemann::service':
    config_file => $config_file,
    require     => Anchor['riemann::start'],
    before      => Anchor['riemann::end'],
  }

  anchor { 'riemann::end': }
}