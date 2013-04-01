class riemann::riak(
  $enable  = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::riak::params::log_dir
) inherits riemann::riak::params {
  anchor { 'riemann::riak::start': }

  class { 'riemann::riak::package':
    require => Anchor['riemann::riak::start'],
    before  => Anchor['riemann::riak::end'],
  } ->
  class { 'riemann::riak::config':
    require => Anchor['riemann::riak::start'],
    before  => Anchor['riemann::riak::end'],
  } ~>
  class { 'riemann::riak::service':
    require => Anchor['riemann::riak::start'],
    before  => Anchor['riemann::riak::end'],
  }

  anchor { 'riemann::riak::end': }
}