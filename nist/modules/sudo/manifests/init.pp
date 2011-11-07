# Module: sudo
#
# Class: sudo
#
# Description:
#	sudo ensures the group 'wheel' exists, adds wheel to sudoers file,
#	and ensures that only wheel members can su -
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
#	sudoers
#
# LinuxGuide:
#	2.3.1.2, 2.3.1.3
#
# CCERef#:
#	None
#
class sudo {
	# GuideSection 2.3.1.3
	# Configure sudo to improve root auditing
	package {
		"sudo":
			ensure => installed;
	}

	file {
		"/etc/sudoers":
			owner   => "root",
			group   => "root",
			mode    => 440,
			source  => "puppet:///modules/sudo/sudoers",
			require => Package["sudo"],
	}

	group {
		"wheel":
			ensure => present;
	}

	# GuideSection 2.3.1.2
	# Limit su access to root account
	augeas {
		"pamsu":
			context => "/files/etc/pam.d/",
			changes => [
				"ins 01 after su/*[last()]",
				"set su/01/type auth",
				"set su/01/control required",
				"set su/01/module pam_wheel.so",
				"set su/01/argument use_uid",
			],
			onlyif =>"match su/*[type='auth'][control='required'][module='pam_wheel.so'] size == 0";
	}
}
