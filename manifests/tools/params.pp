class riemann::tools::params () {

  $health_service_dependencies = [
      Service['riemann'],
      Class['riemann::tools::package'],
      File['/etc/init.d/riemann-health'],
  ]

  $net_service_dependencies = [
      Service['riemann'],
      Class['riemann::tools::package'],
      File['/etc/init.d/riemann-net'],
  ]

  case $::osfamily {
    'Debian': {
      $service_provider = 'upstart'
      $packages = [ 'build-essential', 'ruby', 'rubygems', 'ruby-dev']
    }
    'RedHat': {
      $service_provider = 'redhat'
      $packages = [ 'make', 'automake', 'gcc', 'gcc-c++', 'ruby', 'rubygems',
        'ruby-devel']
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }
}
