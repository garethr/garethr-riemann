class riemann::params () {

  case $::osfamily {
    'Debian': {
      $packages = ['clojure1.3', 'leiningen']
    }
    'RedHat': {
      require epel
      $packages = ['clojure', ]
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }


}
