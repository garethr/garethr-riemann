class riemann::dash::package {

  # requires puppetlabs::stdlib
  define ensure_packages {
    ensure_resource('package', $name, {'ensure' => 'present'})
  }

  ensure_packages {$riemann::dash::params::packages:}

  package { [
      'riemann-dash'
    ]:
      ensure   => installed,
      require  => Package[$riemann::dash::params::packages],
      provider => gem,
  }
}
