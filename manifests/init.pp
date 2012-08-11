class riemann(
  $version='0.1.2',
  $config_file='/etc/riemann.sample.conf'
  ){
    class { 'riemann::package': version    => $version }
    include riemann::config
    class { 'riemann::service': config_file => $config_file }
}
