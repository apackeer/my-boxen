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
  git::config::global { 'push.default': value => 'simple' }
  git::config::global { 'color.ui': value => 'auto' }
  git::config::global { 'color.interactive': value => 'true' }
  git::config::global { 'color.diff': value => 'true' }
  git::config::global { 'alias.lg': value => "log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cr%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph --date-order" }
  git::config::global { 'alias.review': value => 'log -p --reverse -M -C -C --patience --no-prefix' }
  git::config::global { 'alias.ll': value => 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat' }
  git::config::global { 'alias.dlc': value => 'diff --cached HEAD^' }

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

  ###############
  # User Config #
  ###############

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

}
