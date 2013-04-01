class riemann::config {
  $host          = $riemann::host
  $port          = $riemann::port
  $config_file   = $riemann::config_file
  $config_source = $riemann::config_file_source ? {
    ''      => undef,
    default => $riemann::config_file_source,
  }
  $config_content = $riemann::config_file_source ? {
    ''      => template($riemann::config_file_template),
    default => undef,
  }
  $user          = $riemann::user
  $group         = $riemann::group

  file { '/etc/riemann':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $config_file:
    ensure  => present,
    source  => $config_source,
    content => $config_content,
    owner   => $user,
    group   => $group,
    mode    => '644',
    require => File['/etc/riemann'],
  }

  file { '/etc/puppet/riemann.yaml':
    ensure  => present,
    content => template('riemann/puppet/riemann.yaml.erb'),
  }
}