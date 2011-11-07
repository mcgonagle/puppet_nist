# Module: puppet
#
# Class: puppet
#
# Description:
#	This class ensures the client's puppet.conf file is sourced properly
#	from the one in this module (allowing for easy updates) and that
#	permissions are properly set.
#
# Defines:
#	None
#
# Variables:
#	None
#
# Facts:
#	None
#
# Files:
#	puppet.conf
#
# LinuxGuide:
#	None
#
# CCERef#:
#	None
#
class puppet {
	file {	
		"/etc/puppet/puppet.conf":
			owner   => "root",
			group   => "wheel",
			mode    => 644,
			replace => true,
			source  => "puppet:///modules/puppet/puppet.conf";
	}
}
