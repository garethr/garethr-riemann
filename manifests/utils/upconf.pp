# manage an upstart service conf - makes
# the upstart stanzas typeable from puppet,
# creates a notification from the conf file
# to the service of the same name.
#
# Parameters
# - ensure: ensure given to file - main toggle of this define
# - file: default empty, give if you want to override templ
# - template: default 'riemann/upconf.conf.erb', override if you want
#    to give a different template
# - user: user to run the service as, defaults to root
# - description: description of svc
# - respawn: whether to respawn the service if it dies; default true
# - exec: the required exec stanza
#
define riemann::utils::upconf(
  $ensure      = 'present',
  $file        = '',
  $template    = 'riemann/upconf.conf.erb',
  $user        = undef,
  $description = undef,
  $respawn     = true,
  $exec
) {
  # content should be set to a default if no file
  $manage_config_content = $file ? {
    ''      => template($template),
    undef   => template($template),
    default => undef,
  }

  # source should be set if we have a config file
  $manage_config_source = $file ? {
    ''      => undef,
    undef   => undef,
    default => $file,
  }

  $manage_link_ensure = $ensure ? {
    'present' => 'link',
    default   => 'absent'
  }

  if $ensure == 'present' {
    Service[$title] { require +> File["/etc/init/$title.conf"] }
  }

  file { "/etc/init.d/$title":
    ensure => $manage_link_ensure,
    target => '/lib/init/upstart-job',
  }

  file { "/etc/init/$title.conf":
    ensure  => $ensure,
    source  => $manage_config_source,
    content => $manage_config_content,
  }

  if $user != undef and $ensure == 'present' {
    File["/etc/init/$title.conf"] { require +> User[$user] }
  }

  if $ensure == 'present' {
    # when the upstart file changes, restart the service
    File["/etc/init/$title.conf"] ~> Service[$title]
  }
}