class riemann::tools::params {

  case $::osfamily {
    'Debian': {
      $service_provider = 'upstart'
      $packages = [
        'build-essential',
        'ruby',
        'rubygems',
        'ruby-dev'
      ]
    }
    'RedHat': {
      $service_provider = 'redhat'
      $packages = [ 
        'make',
        'automake',
        'gcc',
        'gcc-c++',
        'ruby',
        'rubygems',
        'ruby-devel'
      ]
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }

  $log_dir = '/var/log/riemann-tools'
}