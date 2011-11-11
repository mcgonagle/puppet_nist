# Class: fabric::params
#
# This module manages fabric::params
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
class fabric::params {
	$packages = $operatingsystem ? {
      		'CentOS'  => 'python-pip',
      		'ubuntu' => 'python-setup-tools',
      		default  => undef, }
	

}
