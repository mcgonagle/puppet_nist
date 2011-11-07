# Class: vagrant::ssh::config
#
# This module manages vagrant
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class vagrant::ssh::config {
  file { "/etc/rc3.d/S11sshd":
    ensure => link,
    target => "../init.d/sshd",
  }

  file { "/etc/rc5.d/S11sshd":
    ensure => link,
    target => "../init.d/sshd",
  }

}
