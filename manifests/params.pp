class riemann::params {
  $version     = '0.1.5'
  $config_file = '/etc/riemann.sample.config'
  $dir     = '/opt/riemann'
  $bin_dir = "$dir/bin"
  $log_dir = "/var/log/riemann"

  case $::osfamily {
    'Debian': {
      $packages = ['clojure1.4']
      $service_provider = 'upstart'
      $service_config_template = 'riemann/init/riemann.conf.debian.erb'
    }
    'RedHat', 'Amazon': {
      require epel
      $service_provider = 'redhat'
      $packages = ['clojure']
      $service_config_template = 'riemann/init/riemann.conf.redhat.erb'
    }
    default: {
      err("$::operatingsystem not supported")
    }
  }
}