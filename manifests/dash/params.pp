class riemann::dash::params {

  case $::osfamily {
    'Debian': {
      $packages = [ 'build-essentials']
    }
    'RedHat': {
      $packages = [ 'make', 'automake', 'gcc', 'gcc-c++', 'ruby-devel']
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }



}
