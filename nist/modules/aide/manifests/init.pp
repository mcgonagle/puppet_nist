# Module: aide
#
# Class: aide
#
# Description:
#	This class installs and sets up aide.
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
#	2.1.3.1.1
#	2.1.3.1.3
#	2.1.3.1.4
#
# CCERef#:
#	CCE-4209-3
#
# TODO:
#	Use run stage to make sure this is one of the last things run.
#
class aide {
	# GuideSection 2.1.3.1.1
	# CCE-4209-3
	# Ensure aide is installed
	package {
		"aide":
			ensure => installed;
	}
	
	# GuideSection 2.1.3.1.3
	# Build the initial aide database and install it for use
	exec {
		"Aide Init, 2.1.3.1.3":
			command => "/usr/sbin/aide --init",
			creates => "/var/lib/aide/aide.db.new.gz",
			user    => "root",
			timeout => "-1",
			require => Package["aide"];

		"Install Aide Database, 2.1.3.1.3":
			command => "/bin/cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz",
			creates => "/var/lib/aide/aide.db.gz",
			user    => "root",
			require => [Package["aide"],Exec["Aide Init, 2.1.3.1.3"]];
	}
	
	# GuideSection 2.1.3.1.4
	# Set periodic integrity checks
	cron {
		"aide":
			command => "/usr/sbin/aide --check",
			user    => "root",
			hour    => 4,
			minute  => 05,
			require => Package["aide"];
	}
}
