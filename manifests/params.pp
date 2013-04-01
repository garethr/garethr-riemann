class riemann::params {
  $version     = '0.2.0'
  $config_file = 'puppet:///riemann/riemann.config'

  $port        = 5555
  $host        = '0.0.0.0'

  $dir     = '/opt/riemann'
  $bin_dir = "$dir/bin"
  $log_dir = "/var/log/riemann"

  $group   = 'riemanns'
  $user    = 'riemann'

  case $::osfamily {
    'Debian': {
      $packages = ['clojure1.5']
    }
    'RedHat', 'Amazon': {
      require epel
      $packages = ['clojure']
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }
  case $::osfamily {
    'Debian': {
      $tools_packages = [
        'build-essential',
        'ruby',
        'rubygems',
        'ruby-dev'
      ]
    }
    'RedHat', 'Amazon': {
      $tools_packages = [ 
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
}