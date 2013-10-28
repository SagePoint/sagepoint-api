define add_user ( $uid, $groups = [], $comment, $hash, $max_age ) {
  $username = $title

  user { $username:
    password => "$hash",
    password_max_age => "$max_age",
    ensure => 'present',
    comment => $comment,
    home    => "/home/$username",
    shell   => "/bin/bash",
    uid     => $uid,
    groups => $groups,
  }

  group { $username:
    gid     => $uid,
    require => User[$username]
  }

  file { "/home/$username/":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => 655,
    require => [ User[$username], Group[$username] ]
  }

  file { "/home/$username/.bash_profile":
    owner => $username,
    group => $username,
    mode  => 600,
    require => File["/home/$username"],
    content => template("users/default_bash_profile.erb"),
  }

}

define add_group ($gid) {

  group { $title:
    gid => $gid,
  }

}