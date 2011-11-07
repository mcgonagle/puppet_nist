# Module: ssh
#
# Class: ssh
#
# Description:
#	The ssh module configures /etc/ssh/sshd_config by adding
#	rules that limit client behavior and installs sshd if it
#	is not already available.
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
#	3.5.2
#	3.5.2.1, 3.5.2.3, 3.5.2.4, 3.5.2.5, 3.5.2.6, 3.5.2.7, 3.5.2.8
#
# CCERef#:
#	CCE-3660-8, CCE-3845-5, CCE-4325-7, CCE-4370-3, CCE-4387-7,
#	CCE-4431-3, CCE-4475-0
#
# Notes:
#	Tightening down iptables rules would also be recommended. By default,
#	a rule will need to be added to iptables to enable SSH traffic. When
#	adding such a rule, limit the range of ip addresses that can connect to
#	local network users and block incoming SSH access completely at the
#	network edge.
#
class ssh {
	# GuideSection
	# 3.5.2 3.5.2.1 3.5.2.3 3.5.2.4 3.5.2.5 3.5.2.6 3.5.2.7 3.5.2.8
	# Configure ssh server
	package {
		"openssh-clients":
			ensure => installed;
		"openssh-server":
			ensure => installed;
	}

	service {
		"sshd":
			ensure    => true,
			enable    => true,
			hasstatus => true,
			require   => Package["openssh-server"];
	}

	augeas {
		"sshd_config, 3.5.2.*":
			context => "/files/etc/ssh/sshd_config",
			lens    => "sshd.lns",
			incl    => "/etc/ssh/sshd_config",
			changes => [
				"set Protocol 2",
				"set ClientAliveInterval 900",
				"set ClientAliveCountMax 0",
				"set IgnoreRhosts yes",
				"set HostbasedAuthentication no",
				"set PermitRootLogin no",
				"set PermitEmptyPasswords no",
				"set Banner /etc/issue",
				"set PermitUserEnvironment no",
				"set Ciphers aes128-ctr,aes192-ctr,aes256-ctr",
			];
	}
}
