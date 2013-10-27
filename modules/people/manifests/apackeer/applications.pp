class people::apackeer::applications (
  $my_homedir   = $people::apackeer::params::my_homedir,
  $my_sourcedir = $people::apackeer::params::my_sourcedir,
  $my_username  = $people::apackeer::params::my_username
) {

  # Include ALL the browsers
  include chrome
  include firefox

  # dev-y stuff that I want even outside of projects
  include python
  include python::virtualenvwrapper

  # editors
  include sublime_text_2
  include vim

  # terminal stuff
  include iterm2::dev
  include autojump

  # non-dev stuff for general productivity
  include alfred
  include fonts::source_code_pro
  include github_for_mac
  include vlc
  include flux
  include caffeine
  include dropbox
  include rdio
  include onepassword

  # virtual machines
  include vmware_fusion
  include vagrant

  #####################
  # Homebrew Packages #
  #####################

  package {
    [
      'bash',
      'coreutils',
      'curl',
      'dos2unix',
      'gawk',
      'netcat',
      'nmap',
      'ngrep',
      'par2',
      'tmux',
      'tree',
      'wget',
      'zsh'
    ]:
  }

  repository { "${my_sourcedir}/dotfiles":
    source => 'apackeer/dotfiles',
  }

  repository { "${my_sourcedir}/oh-my-zsh":
    source  => 'robbyrussell/oh-my-zsh',
  }

  repository { "${my_sourcedir}/solarized":
    source  => 'altercation/solarized',
  }
}
