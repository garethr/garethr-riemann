class riemann::params {
  $version = '0.2.0'
  $config_file = '/etc/riemann.sample.config'
  $dash_port = 4567
  $dash_host = 'localhost'
  $port = 5555
  $host = 'localhost'

  case $::osfamily {
    'Debian': {
      $service_provider = upstart
    }
    'RedHat', 'Amazon': {
      include epel
      $service_provider = redhat
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
