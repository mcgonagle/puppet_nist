# Module: ipv6
#
# Class: ipv6
#
# Description:
#	This class disables the ipv6 networking and stops the ipv6 iptables.
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
#	2.5.3.1.2
#
# CCERef#:
#	None
#
class ipv6 {
	service {
		"ip6tables":
			ensure    => false,
			enable    => false,
			hasstatus => true;
	}

	# GuideSection 2.5.3.1.2
	augeas {
		"ipv6if" :
			context => "/files/etc/sysconfig/network",
			lens    => "shellvars.lns",
			incl    => "/etc/sysconfig/network",
			changes => [
				"set NETWORKING_IPV6 no",
				"set IPV6INIT no",
			],
	}
}
