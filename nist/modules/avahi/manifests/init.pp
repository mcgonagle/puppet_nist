# Module: avahi
#
# Class: avahi
#
# Description:
#	This class disables avahi. The corresponding firewall rule is removed
#	by the iptables module.
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
#	3.7.1.1
#	3.7.1.2
#
# CCERef#:
#	CCE-4365-3
#
class avahi {
	# GuideSection 3.7.1.1
	# CCE-4365-3
	# Disable avahi server
	service {
		"avahi-daemon":
			ensure    => false,
			enable    => false,
			hasstatus => true,
	}	
	
	# GuideSection 3.7.1.2
	# Remove firewall rule in iptables module
}
