define riemann::utils::stduser(
  $home = undef,
  $group
) {
  $manage_user = $name ? {
    ''      => $title,
    undef   => $title,
    default => $name,
  }
  $manage_group = $group ? {
    ''      => $title,
    undef   => $title,
    default => $group,
  }
  $manage_home = $home ? {
    ''      => "/home/$title",
    undef   => "/home/$title",
    default => $home,
  }

  Group <| title == $group |>

  file { $manage_home:
    ensure => directory,
    owner  => $manage_user,
    group  => $manage_group,
  }

  user { $manage_user:
    ensure  => present,
    system  => true,
    gid     => $manage_group,
    home    => $home,
    shell   => '/bin/bash',
  }
}