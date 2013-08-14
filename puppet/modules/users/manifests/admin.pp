class users::admin {

  import 'base.pp'

  add_group { admin:
    gid => 500,
  }

  file { "/root/.bash_profile":
    owner => root,
    group => root,
    mode  => 600,
    content => template("users/default_bash_profile.erb"),
  }
}