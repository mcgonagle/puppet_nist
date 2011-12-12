# Class: fabric::service
#
# This module manages fabric::service
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
class fabric::service {

	service { "fabric":
 		enable => false,
 		ensure => stopped,
 		##multiple subscribe calls
 		subscribe => Class["fabric::config"],
		}


}
