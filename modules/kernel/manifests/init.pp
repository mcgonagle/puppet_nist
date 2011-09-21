# Module: kernel
#
# Class: kernel
#
# Description:
#	This class sets various Kernel parameters and removes wireless drivers.
#
# Defines:
#	None
#
# Variables:
#	None
#
# Facts:
#	cpu_nx - searches /proc/cpuinfo to see if no execute (nx) support is supported
#	kernel_nx - determines if PAE enabled kernel is in use
#
# Files:
#	cpu_nx.rb
#	kernel_nx.rb
#
# LinuxGuide:
#	2.5.1.1
#	2.5.1.2
#
# CCERef#:
#	CCE-4151-7, CCE-3561-8, CCE-4155-8, CCE-3339-9, CCE-4320-8, CCE-3644-2
#	CCE-4217-6, CCE-3840-6, CCE-3472-8, CCE-4186-3, CCE-4080-8, CCE-4091-5
#	CCE-4236-6, CCE-4133-5, CCE-4265-5, CCE-4170-7
#
class kernel {
	# GuideSection 2.2.4.4
	# Ensure eXecute Disable/No eXecute Support is enabled
	if $cpu_nx == "true" and $kernel_nx == "false" {
		crit("This processor has Execute Disable/No Execute support; ensure it is BIOS-enabled and install an x86 PAE or x86_64 kernel")
	}

	augeas {
		# GuideSection 2.5.1
		# Kernel parameters which affect networking
		# GuideSection 2.5.1.1 2.5.1.2
		# CCE-4151-7, CCE-3561-8, CCE-4155-8, CCE-3339-9, CCE-4320-8, CCE-3644-2
		# CCE-4217-6, CCE-3840-6, CCE-3472-8, CCE-4186-3, CCE-4080-8, CCE-4091-5
		# CCE-4236-6, CCE-4133-5, CCE-4265-5
		# Network for hosts
		"Network Kern Parms, 2.5.1":
			context => "/files/etc/sysctl.conf",
			lens    => "sysctl.lns",
			incl    => "/etc/sysctl.conf",
			changes => [
				"set net.ipv4.ip_forward 0",
				"set net.ipv4.conf.all.send_redirects 0",
				"set net.ipv4.conf.default.send_redirects 0",
				"set net.ipv4.conf.all.accept_source_route 0",
				"set net.ipv4.conf.all.accept_redirects 0",
				"set net.ipv4.conf.all.secure_redirects 0",
				"set net.ipv4.conf.all.log_martians 1",
				"set net.ipv4.conf.default.accept_source_route 0",
				"set net.ipv4.conf.default.accept_redirects 0",
				"set net.ipv4.conf.default.secure_redirects 0",
				"set net.ipv4.icmp_echo_ignore_broadcasts 1",
				"set net.ipv4.icmp_ignore_bogus_error_responses 1",
				"set net.ipv4.tcp_syncookies 1",
				"set net.ipv4.conf.all.rp_filter 1",
				"set net.ipv4.conf.default.rp_filter 1",
				"set net.ipv6.conf.default.accept_redirects 0",
				"set net.ipv6.conf.default.accept_ra 0",
			];

		# GuideSection 3.3.9.3
		# Disable zeroconf
		"Disable Zeroconf, 3.3.9.3":
			context => "/files/etc/sysconfig/network",
			lens    => "shellvars.lns",
			incl    => "/etc/sysconfig/network",
			changes => "set NOZEROCONF yes",
	}
}
