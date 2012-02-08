# Module: ntp
#
# Class: ntp
#
# Description:
#	This class configures and launches ntp
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
# Files:
#	ntp.conf.erb
#
# LinuxGuide:
#	3.10.2.1.1
#	3.10.2.1.2
#
# CCERef#:
#	CCE-4292-9
#
class ntp {
	# GuideSection 3.10.2.1.1
	package {
		"ntp":
			ensure => installed,
	}

	file {
		"/etc/ntp.conf":
			owner   => "root",
			group   => "root",
			mode    => 644,
			content => template("ntp/ntp.conf.erb"),
			require => Package["ntp"],
	}

	service {
		"ntpd":
			ensure     => true,
			enable     => true,
			hasstatus  => true,
			hasrestart => true,
			require => File["/etc/ntp.conf"],
	}



	# Set the clock whenever ntp.conf is changed, and allow large clock changes
	exec {
		"ntp initial clock set":
			subscribe   => File["/etc/ntp.conf"],
			command     => "/usr/sbin/ntpd -g -q -u ntp:ntp",
			refreshonly => true,
			# Usable timeout to hide "command timed out" errors
			timeout     => "-1",
	}

}
