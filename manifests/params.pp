class riemann::params () {

  # Common dependencies for the service. We'll add OS specific
  # dependencies below.
  $service_dependencies = [ File['/etc/init.d/riemann'],
                            Class['riemann::package'], ]

  case $::osfamily {
    'Debian': {
      $packages = ['clojure1.3', ]
      $service_provider = 'upstart'
    }
    'RedHat': {
      require epel
      $service_provider = 'redhat'
      $packages = ['clojure', ]
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }


}
