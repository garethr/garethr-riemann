class riemann::params () {

  case $::osfamily {
    'Debian': {
      $packages = ['clojure1.3', 'leiningen']
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }


}
