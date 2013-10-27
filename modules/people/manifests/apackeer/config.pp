class people::apackeer::config (
  $my_homedir   = $people::apackeer::params::my_homedir,
  $my_sourcedir = $people::apackeer::params::my_sourcedir,
  $my_username  = $people::apackeer::params::my_username
) {

  #####################
  # Git Configuration #
  #####################

  git::config::global { 'user.name': value => 'Arden Packeer' }
  git::config::global { 'user.email': value => 'contactme@ardenpackeer.com' }
  git::config::global { 'core.editor': value => '/usr/bin/vim'}
  git::config::global { 'push.default': value => 'simple' }

  ########################
  # Nodejs Configuration #
  ########################

  class { 'nodejs::global': version => 'v0.10.21' }
  nodejs::module { 'bower': node_version => 'v0.10.21' }
  nodejs::module { 'coffee-script': node_version => 'v0.10.21' }

  ################
  # OSX Settings #
  ################

  # GLOBAL SETTINGS

  # disable press-and-hold for accented character entry
  include osx::global::disable_key_press_and_hold

  # enables the keyboard for navigating controls in dialogs
  include osx::global::enable_keyboard_control_access

  # expand the print dialog by default
  include osx::global::expand_print_dialog

  # expand the save dialog by default
  include osx::global::expand_save_dialog

  # disable remote control infrared receiver
  include osx::global::disable_remote_control_ir_receiver

  # disables spelling autocorrection
  include osx::global::disable_autocorrect

  # DOCK SETTINGS

  # automatically hide the dock
  include osx::dock::autohide

  # ensures the dock only contains apps that are running
  # osx::dock::clear_dock

  # FINDER SETTINGS

  # unset the hidden flag on ~/Library
  include osx::finder::unhide_library

  # disable creation of .DS_Store files on network shares
  include osx::no_network_dsstores

  # disable the downloaded app quarantine
  include osx::disable_app_quarantine

  # automatically run software-update
  include osx::software_update

  #######
  # ZSH #
  #######

  # Changes the default shell to the zsh version we get from Homebrew
  # Uses the osx_chsh type out of boxen/puppet-osx
  osx_chsh { 'apackeer':
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh'],
  }

  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
  }

  ############
  # dotfiles #
  ############

  file { "/Users/${my_username}/.zshrc":
    ensure  => link,
    mode    => '0644',
    target  => "${my_sourcedir}/dotfiles/.zshrc",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.oh-my-zsh":
    ensure  => link,
    mode    => '0644',
    target  => "${my_sourcedir}/oh-my-zsh",
    require => Repository["${my_sourcedir}/oh-my-zsh"],
  }

  file { "/Users/${my_username}/.dir_colors":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.dir_colors",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.hushlogin":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.hushlogin",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.aliases":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.aliases",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.gitattributes":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.gitattributes",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.gitconfig":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.gitconfig",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.exports":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.exports",
    require => Repository["${my_sourcedir}/dotfiles"],
  }

  file { "/Users/${my_username}/.functions":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.functions",
    require => Repository["${my_sourcedir}/dotfiles"],
  }


  ##########################
  # User Config - Sublime #
  ##########################

  # TODO: install ST2 license file

  sublime_text_2::package { 'Solarized Color Scheme':
    source => 'SublimeColors/Solarized'
  }

  sublime_text_2::package { 'Puppet':
    source => 'russCloak/SublimePuppet'
  }

  sublime_text_2::package { 'SidebarEnhancements':
    source => 'titoBouzout/SideBarEnhancements'
  }

  sublime_text_2::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
  }

  sublime_text_2::package { 'Theme - Soda':
    source => 'buymeasoda/soda-theme'
  }

  sublime_text_2::package { 'Git':
    source => 'kemayo/sublime-text-git'
  }

  sublime_text_2::package { 'Package Control':
    source => 'wbond/sublime_package_control'
  }

  file { "/Users/${::luser}/Library/Application Support/Sublime Text 2/Packages/User/Preferences.sublime-settings":
    content => template('people/apackeer/Preferences.sublime-settings.erb'),
    force   => true,
    group   => 'staff',
    owner   => $::luser,
    require => Package['SublimeText2'],
  }

  #######
  # vim #
  #######
  vim::bundle {
    [
      'altercation/vim-colors-solarized',
    ]:
  }

  file { "/Users/${my_username}/.vimrc":
    ensure => link,
    mode   => '0644',
    target => "${my_sourcedir}/dotfiles/.vimrc",
    require => Repository["${my_sourcedir}/dotfiles"],
  }
}
