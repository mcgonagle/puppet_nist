# Module: services
#
# Class: services
#
# Description:
#	This module is made specifically to enable and disable appropriate
#	services for WORKSTATIONS only, not for servers. Special exemptions
#	must be made for specific servers to enable specific services, and
#	this class is likely to become very unwieldy if those changes are
#	incorporated inside this module.
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
#	2.1.2.2, 3.1.2, 3.2.1, 3.2.2, 3.2.2.1, 3.2.3.1, 3.2.3.3, 
#	3.2.4, 3.2.4, 3.2.5, 3.3.1, 3.3.10, 3.3.11, 3.3.12, 
#	3.3.13.1, 3.3.13.2, 3.3.14.1, 3.3.14.2, 3.3.15.1, 
#	3.3.15.2, 3.3.2, 3.3.3, 3.3.4, 3.3.5, 3.3.6, 
#	3.3.7, 3.3.8, 3.4.1, 3.6.1.3.2, 3.8.3, 
#	3.9.3, 3.15.1, 3.16.1, 3.18.1, 3.19, 
#	3.20.1
#
# CCERef#:
#	CCE-3416-5, CCE-4023-8, CCE-4252-3, CCE-4164-0,
#	CCE-4234-1, CCE-3390-2, CCE-4330-7, CCE-3974-3,
#	CCE-4141-8, CCE-3537-8, CCE-3705-1, CCE-4348-9,
#	CCE-4273-9, CCE-3916-4, CCE-4421-4, CCE-4302-6,
#	CCE-4355-4, CCE-4377-8, CCE-4286-1, CCE-3425-6,
#	CCE-4074-1, CCE-3919-8, CCE-4338-0, CCE-4308-3,
#	CCE-4336-4, CCE-3765-5
#
class services {

	# GuideSection 3.1.2
	# Settings for default services (where not specified in other modules)
	service {
		[
			"acpid",	#3.3.15.2
			"restorecond",
			"smartd",	#3.3.11
		]:
			ensure    => true,
			enable    => true,
			hasstatus => true;

		[
			"anacron",		#3.4.1
			"cups",			#3.8.1
			"dhcpd",		#3.9.3
			#"gpm",			#3.3.2 - console mouse services
			"haldaemon",		#3.3.13.2
			"hplip",		#3.8.4.1
			"httpd",		#3.16.1 (apache2)
			"inetd",		#3.2.1
			"irqbalance",		#3.3.3
			"kdump",		#3.3.5
			"mdmonitor",		#3.3.7
			"pcscd",		#3.3.10
			"rhnsd",		#2.1.2.2
			"snmpd",		#3.20.1
			"smb",			#3.18.1		#CCE-4551-8
			"squid",		#3.19		#CCE-4556-7
			"vsftpd",		#3.15.1
			"xfs",			#3.6.1.3.2
			"xinetd",		#3.2.1
			"ypbind",		#3.2.4
		]:
			ensure    => false,
			enable    => false,
			hasstatus => true;
	
		# These services are disabled, but they dont have a working
		# status function.
		[
			"apmd",			#3.3.14.2
			"bluetooth",		#3.3.14.2
			"dns",			#3.14.1
			"dovecot",		#3.17.1
			"firstboot",		#3.3.1
			"hidd",			#3.3.14.2
			"irda",			#3.3.16.1
			"isdn",			#3.3.4
			"kudzu",		#3.3.6
			"messagebus",		#3.3.13.1
			"microcode_ctl",	#3.3.8
			"rawdevices",
			"readahead_early",	#3.3.12
			"readahead_later",	#3.3.12
		]:
			ensure => false,
			enable => false,
	}
	# Remove unneeded services
	# GuideSections 3.2.1, 3.2.2, 3.2.2.1, 3.2.3.1, 3.2.3.3,
	#		3.2.4, 3.2.5
	package {
		"dhcp":			ensure => absent;
		"dns":			ensure => absent;
		"dovecot":		ensure => absent;
		"gnome-user-share":	ensure => absent; # This depends on httpd
		"httpd":		ensure => absent;
		"inetd":		ensure => absent;
		"ipsec-tools":		ensure => absent;
		"irda-utils":		ensure => absent;
		"isdn4k-utils":		ensure => absent;
		"krb5-workstation":	ensure => absent;
		"net-snmp":		ensure => absent;
		"rsh-server":		ensure => absent;
		"rsh":			ensure => absent;
		"squid":		ensure => absent;
		"talk":			ensure => absent;
		"telnet":		ensure => absent;
		"telnet-server":	ensure => absent;
		"tftp-server":		ensure => absent;
		"vsftpd":		ensure => absent;
		"xinetd":		ensure => absent;
		"ypserv":		ensure => absent;
	}

	# Disable X Window System Listening
	# Guidesection 3.6.1.3.2
	file {
		"/etc/X11/xinit/xserverrc":
			content => "exec X :0 -nolisten tcp $@",
	}
}
