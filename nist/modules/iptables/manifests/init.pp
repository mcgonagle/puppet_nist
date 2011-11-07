# Module: iptables
#
# Class: iptables
#
# Description:
#	This class configures the iptables firewall.
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
#	2.5.5.1
#	2.5.5.3.1
#	3.7.1.2
#	3.8.2
#
# CCERef#:
#	CCE-4189-7
#
class iptables {
	# GuideSection 2.5.5
	# Enable the iptables services
	service {
		"iptables":
			ensure    => true,
			enable    => true,
			hasstatus => true;
	}

	augeas {
		"2.5.5.3.1 Change the Default Policies":
			context => "/files/etc/sysconfig/iptables",
			lens    => "iptables.lns",
			incl    => "/etc/sysconfig/iptables",
			changes => [
				"set table/*[. = 'INPUT']/policy DROP",
				"set table/*[. = 'FORWARD']/policy DROP",
			],
			onlyif  => "match table/*[. = 'INPUT'][policy = 'ACCEPT'] size == 0";
		"3.7.1.2 Remove Avahi Server iptables Firewall Exception":
			context => "/files/etc/sysconfig/iptables",
			lens    => "iptables.lns",
			incl    => "/etc/sysconfig/iptables",
			changes => [
				"rm table/*[. = 'RH-Firewall-1-INPUT'][protocol = 'udp'][dport = '5353'][jump = 'ACCEPT']",
			];
		"3.8.2 Disable Firewall Access to Printing Service if Possible":
			context => "/files/etc/sysconfig/iptables",
			lens    => "iptables.lns",
			incl    => "/etc/sysconfig/iptables",
			changes => [
				"rm table/*[. = 'RH-Firewall-1-INPUT'][protocol = 'udp'][dport = '631'][jump = 'ACCEPT']",
				"rm table/*[. = 'RH-Firewall-1-INPUT'][protocol = 'tcp'][dport = '631'][jump = 'ACCEPT']",
			];
	}
}
