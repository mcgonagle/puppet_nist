# Class: fabric
#
# This module manages fabric
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
class fabric inherits fabric::params {

	Class ["fabric::user"] -> Class["fabric::install"] -> Class["fabric::config"] -> Class["fabric::service"] 

	class {"fabric::user": }
	class {"fabric::install": }
	class {"fabric::config": }
	class {"fabric::service": }

	

}
