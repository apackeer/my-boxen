class people::apackeer {

  # Set global profile parameters and variables
  include people::apackeer::params
  include people::apackeer::applications
  include people::apackeer::config

  notify { 'class people:apackeer declared': }

}
