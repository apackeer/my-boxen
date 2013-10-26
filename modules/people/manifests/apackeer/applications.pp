class people::apackeer::applications (
  $my_homedir   = $people::apackeer::params::my_homedir,
  $my_sourcedir = $people::apackeer::params::my_sourcedir,
  $my_username  = $people::apackeer::params::my_username
) {

  include chrome
  include python
  include python::virtualenvwrapper
  include iterm2::dev
  include alfred
  include sublime_text_2
  include autojump
  include fonts::source_code_pro

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
      'vim',
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
