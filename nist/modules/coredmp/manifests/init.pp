# Module: coredump
#
# Class: coredump
#
# Description:
#	This class disables coredumps
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
#	2.2.4.2
#
# CCERef#:
#	CCE-4209-3
#	CCE-4247-3
#
class coredmp {
	# GuideSection 2.2.4.2
	# CCE-4225-9
	# CCE-4247-3
	# Disable core dumps
	augeas {
		"/etc/security/limits.conf":
			context => "/files/etc/security/limits.conf",
			lens    => "limits.lns",
			incl    => "/etc/security/limits.conf",
			changes => [
				"set domain '*'",
				"set domain/type hard",
				"set domain/item core",
				"set domain/value 0",
			];
		"/etc/sysctl.conf":
			context => "/files/etc/sysctl.conf",
			lens    => "sysctl.lns",
			incl    => "/etc/sysctl.conf",
			changes => "set fs.suid_dumpable 0";
	}
}
