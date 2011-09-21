# Module: execshield
#
# Class: execshield
#
# Description:
#	This class makes sure execshield is enabled
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
#	2.2.4.3
#
# CCERef#:
#	CCE-4168-1
#	CCE-4146-7
#
class execshield {
	# GuideSection 2.2.4.3
	# CCE-4168-1, CCE-4146-7
	# Enable execshield
	augeas {
		"Enable ExecShield, 2.2.4.3":
			context => "/files/etc/sysctl.conf",
			lens    => "sysctl.lns",
			incl    => "/etc/sysctl.conf",
			changes => [
				"set kernel.exec-shield 1",
				"set kernel.randomize_va_space 1",
			];
	}
}
