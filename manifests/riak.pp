class riemann::riak(
  $enable  = true,
  $config_file = '',
  $config_file_template = '',
  $log_dir = $riemann::params::log_dir
) inherits riemann::params {
  $user = $riemann::params::riak_user

  anchor { 'riemann::riak::start': }

  riemann::utils::stduser { $user:
    group => $group,
    require => Anchor['riemann::riak::start'],
    before  => Anchor['riemann::riak::end'],
  } ->
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