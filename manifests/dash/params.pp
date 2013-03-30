class riemann::dash::params {
  case $::osfamily {
    'Debian': {
      $service_provider = 'upstart'
      $packages = [ 
        'build-essential',
        'ruby',
        'rubygems',
        'ruby-dev'
      ]
      $dash_config_template = 'riemann/riemann-dash.conf.debian.erb'
    }
    'RedHat', 'Amazon': {
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
      $dash_config_template = 'riemann/riemann-dash.conf.redhat.erb'
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }
  
  $log_dir = '/var/log/riemann-dash'
}