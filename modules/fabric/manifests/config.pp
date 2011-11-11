# Class: fabric::config
#
# This module manages fabric::config
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
class fabric::config {

	file{"/etc/fabric/fabric.conf":
	 content => template("fabric/${operatingsystem}/fabric.conf.erb"),
	 owner => "root", group => "root", mode => "0755", }
	
	file{"/etc/fabric/fabric.conf":
	 source => [ "puppet:///modules/fabric/fabric.conf.${role}",
	 	     "puppet:///modules/fabric/fabric.conf.${operatingsystem}",
	 	     "puppet:///modules/fabric/fabric.conf" ],
	 owner => "root", group => "root", mode => "0755", }

	


}
