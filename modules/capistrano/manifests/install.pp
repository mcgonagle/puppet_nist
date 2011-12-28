# Class: capistrano::install
#
# This module manages capistrano::install
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
class capistrano::install {

	package {"capistrano: ensure => installed, 
		source => "http://gems.github.com/",
		provider => "gem", }

	package {"murder: ensure => installed,
		source => "http://gems.github.com/",
		provider => "gem",
		require => Package["capistrano"], }


}
