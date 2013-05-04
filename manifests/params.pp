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
      $libxml_package = 'libxml2-dev'
      $libxslt_package = 'libxslt-dev'
    }
    'RedHat', 'Amazon': {
      include epel
      $service_provider = redhat
      $libxml_package = 'libxml2-devel'
      $libxslt_package = 'libxslt-devel'
      $gem_path = $::operatingsystemrelease ? {
        '5.8'   => '/usr/local/bin/',
        default => '/usr/bin/',
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
