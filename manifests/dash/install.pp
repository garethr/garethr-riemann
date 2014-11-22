class riemann::dash::install {
  include gcc

  ensure_resource('package', $riemann::params::libxml_package, {'ensure' => 'present' })
  ensure_resource('package', $riemann::params::libxslt_package, {'ensure' => 'present' })

  user { 'riemann-dash':
    ensure => present,
  }

  package { 'riemann-dash':
    ensure   => installed,
    require  => Class['gcc'],
    provider => gem,
  }

  if ($riemann::dash::use_s3) {
    case $::osfamily {
      'debian': {
        package {'ruby-dev':
          ensure => "present"
        }
      }
    }
    ->
    package {'fog':
      ensure   => "present",
      provider => "gem",
      require  => Package['ruby-dev'];
    }
  }
}
