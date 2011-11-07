# Module: sendmail
#
# Class: sendmail
#
# Description: 
#	Ensures the sendmail daemon is off and the package uninstalled.
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
#	3.11.2.1
#
# CCERef#:
#	CCE-4293-7
#
class sendmail {
	# Guide Section 3.11.1.1
	# Disable and uninstall sendmail
	package {
		"sendmail":
			ensure => absent;
	}

	service {
		"sendmail":
			ensure => false,
			enable => false;
	}
}
