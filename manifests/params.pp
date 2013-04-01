class riemann::params {
  $version     = '0.2.0'
  $config_file          = '/etc/riemann/riemann.config'
  $config_file_source   = ''
  $config_file_template = 'riemann/riemann.config.erb'

  $port        = 5555
  $wsport      = 5556
  $host        = '0.0.0.0'

  $dir     = '/opt/riemann'
  $bin_dir = "$dir/bin"
  $log_dir = "/var/log/riemann"

  $group   = 'riemanns'
  $user    = 'riemann'
  $use_pkg = true

  $dash_host   = '0.0.0.0'
  $dash_port   = 4567
  $dash_config_file = '/etc/riemann/riemann-dash.rb'
  $dash_user   = 'riemann-user'

  $health_user = 'riemann-health'

  $net_user = 'riemann-net'

  $riak_user = 'riemann-riak'

  $packages = $::osfamily ? {
    /(?i:linux|redhat|amazon)/ => [
      'daemonize'
    ],
    default                    => [
      'openjdk-7-jre'
    ],
  }
  $tools_packages = $::osfamily ? {
    /(?i:linux|redhat|amazon)/ => [ 
      'make',
      'automake',
      'gcc',
      'gcc-c++',
      'ruby',
      'rubygems',
      'ruby-devel'
    ],
    default => [
      'build-essential',
      'ruby',
      'rubygems',
      'ruby-dev'
    ],
  }
  case $::osfamily {
    'RedHat', 'Linux': {
      require epel
    }
  }
}