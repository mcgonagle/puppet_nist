# Class: vagrant::user::config
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
class vagrant::user::config {
  file { "/home/vagrant/.bashrc":
    source => "puppet:///vagrant/bashrc",
    owner => "vagrant", group => "vagrant", mode => 0644,
  }

}
