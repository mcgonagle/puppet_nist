# Class: fabric::install
#
# This module manages fabric::install
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
class fabric::install {
	require python

	package{"${fabric::params::packages}": ensure => latest }

	


}
