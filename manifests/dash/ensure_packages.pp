# requires puppetlabs::stdlib
define riemann::dash::ensure_packages {
  ensure_resource('package', $name, {'ensure' => 'present'})
}
