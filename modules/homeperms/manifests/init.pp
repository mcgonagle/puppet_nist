# Module: homeperms
#
# Class: homeperms
#
# Description:
#	This class ensures the user home directories have the right permissions.
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
# LinuxGuide:
#	2.3.4.2
#
# CCERef#:
#	CCE-4090-7
#
class homeperms {
	# Guide Section 2.3.4.2
	# CCE-4090-7
	# Ensure that User Home Directories are not Group-Writable or World-Readable
	file { "/home":
		mode         => 700,
		recurse      => true,
		recurselimit => 1,
		ignore       => "/home";
	}

	exec { "Fix Home Dir mode":
		command => "chmod 755 /home",
		user    => "root",
		require => File["/home"],
	}
}
