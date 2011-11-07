# Module: rsyslog
#
# Class: rsyslog
#
# Description: 
#	This class configures rsyslog from files included in the templates
#	directory and ensures appropriate log files are present.
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
#	rsyslog.conf.erb
#	rsyslog.erb
#
# LinuxGuide:
#	2.6.1
#	2.6.1.2
#	2.6.1.3
#	2.6.1.4
#
# CCERef#:
#	CCE-3382-9
#	CCE-3679-8
#	CCE-3701-0
#	CCE-4233-3
#	CCE-4260-6
#	CCE-4366-1
#
class rsyslog {

	package {
		"rsyslog":
			ensure => installed,
	}

	# GuideSection 2.6.1
	# CCE-3679-8	
	service {
		"rsyslog":
			ensure    => true,
			enable    => true,
			hasstatus => true,
			require   => Package["rsyslog"];
		"syslog":
			ensure    => false,
			enable    => false,
			hasstatus => true;
	}

	# GuideSection 2.6.1
	# CCE-4260-6
	# Configure syslog	
	file {
		# GuideSection 2.6.1.1, 2.6.1.3
		"/etc/rsyslog.conf":
			owner   => "root",
			group   => "root",
			mode    => 644,
			content => template("rsyslog/rsyslog.conf.erb"),
			require => Package["rsyslog"],
			notify  => Service["rsyslog"];

		# CCE-3382-9
		# GuideSection 2.6.1.1, 2.6.1.3
		"/etc/sysconfig/rsyslog":
			owner   => "root",
			group   => "root",
			mode    => 644,
			content => template("rsyslog/rsyslog.erb"),
			require => Package["rsyslog"],
			notify  => Service["rsyslog"];

		# GuideSection 2.6.1.2
		# CCE-4233-3
		# CCE-4366-1
		# CCE-3701-0
		"/var/log/messages":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/kern.log":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/daemon.log":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/syslog":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/unused.log":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/secure":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/maillog":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
		"/var/log/cron":
			owner  => "root",
			group  => "root",
			mode   => 600,
			ensure => present;
	}
}
