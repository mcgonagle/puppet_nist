# Class: monit::config
#
# This module manages monit::config
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
class monit::config {
	file { "/etc/monit.conf":
 		#source => "puppet:///monit/monit.conf",
		content => template("monit/monit.conf.erb"), 
 		owner => "root", group => "root", mode => 0600,
		}



}
