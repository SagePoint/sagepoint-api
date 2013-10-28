class oh-my-zsh {
  $install = "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh"
  exec { "$install":
    creates => "/home/${::luser}/.oh-my-zsh"
  }
}

Exec {
    environment => "HOME=/home/vagrant/"
}