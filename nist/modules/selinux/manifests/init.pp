# Module: selinux
#
# Class: selinux
#
# File: /etc/puppet/modules/selinux/manifests/init.pp
#
# Description:
#	This class ensures that selinux is properly configured to be enforcing
#	by checking that it is set in /etc/sysconfig/selinux and /etc/grub.conf
#
# Defines:
#	None
#
# Variables:
#	None
#
# Facts:
#	selinux
#	selinux_enforced
#
# LinuxGuide:
#	2.4.2
#	2.4.3.2
#	2.4.2.1
#
# CCERef#:
#	CCE-3624-4
#	CCE-3668-1
#	CCE-3977-6
#
# TODO:
#	Determine if we need to uninstall/disable any setroubleshoot helper
#	services
#
class selinux {
	# GuideSection 2.4
	# Settings for SELinux	
	
	package {
		"setroubleshoot":
			ensure => absent;
		#"setroubleshoot-server": ensure => absent;
		#"setroubleshoot-plugins": ensure => absent;
		#"selinux-policy-strict": ensure => present;
		#"selinux-policy-mls": ensure => present;
	}
	
	service {
		# GuideSection 2.4.3.1
		# Disable setroubleshoot
		"setroubleshoot": 
			ensure    => false,
			enable    => false,
			hasstatus => true;

		# GuideSection 2.4.3.2
		# Disable mcstrans
		"mcstrans": 
			ensure    => false,
			enable    => false,
			hasstatus => true;
	}

	augeas {
		# GuideSection 2.4.2 and 2.4.2.1
		# Turn on selinux
		"selinux-enforcing, 2.4.2.1" :
			context => "/files/etc/sysconfig/selinux",
			lens    => "shellvars.lns",
			incl    => "/etc/sysconfig/selinux",
			changes => [
				"set SELINUX enforcing",
				"set SELINUXTYPE targeted",
			];

		# GuideSection 2.4.2
		# Ensure selinux=0 or enforcing=0 are not in grub.conf
		"no-selinux-off-grub.conf, 2.4.2":
			context => "/files/etc/grub.conf",
			lens    => "grub.lns",
			incl    => "/etc/grub.conf",
			changes =>  [
				"rm title[*]/kernel/selinux[.='0']",
				"rm title[*]/kernel/enforcing[.='0']"
			];
	}

	# GuideSection 2.4.2.1
	# Ensure SELinux is Properly Enabled
	if $selinux != "true" {
		crit("Selinux status=$selinux, which is not true")
	}

	if $selinux_enforced != "true" {
		crit("Selinux mode = $selinux_enforced, which is not true")
	}
}
