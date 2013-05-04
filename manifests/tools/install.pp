class riemann::tools::install {
  include gcc

  ensure_resource('package', $riemann::params::libxml_package, {'ensure' => 'present' })
  ensure_resource('package', $riemann::params::libxslt_package, {'ensure' => 'present' })

  package { [
      'riemann-client',
      'riemann-tools',
    ]:
      ensure   => installed,
      provider => gem,
  }
}
