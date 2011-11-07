# Class: vagrant::hosts::config
#
# This module manages vagrant::hosts::config
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
class vagrant::hosts::config {
  file { "/etc/hosts":
    source => "puppet:///vagrant/hosts",
    owner => "root", group => "root", mode => 0644,
  }

}
