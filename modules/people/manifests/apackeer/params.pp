class people::apackeer::params {
 
  # Set global profile parameters and variables
  $my_username  = $::luser
  $my_homedir   = "/Users/${people::apackeer::params::my_username}"
  $my_sourcedir = $::boxen_srcdir
}

