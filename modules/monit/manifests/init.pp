# Class: monit
#
# This module manages monit
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
class monit {

	class{"monit::install": }
	class{"monit::config":  }
	class{"monit::service": }
	
	Class["monit::install"] -> Class["monit::config"] -> Class["monit::service"]

	
	


}
