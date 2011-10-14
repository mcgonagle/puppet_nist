# Module: yum
#
# Class: yum
#
# Description:
#	This class ensures gpgcheck is set to 1 for all repositories and
#	verifies permissions on repo files. It also disables yum-updatesd and
#	enables a cron job to check for yum updates.
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
#	yum.cron
#
# LinuxGuide:
#	2.1.2.3
#	2.1.2.3.2
#	2.1.2.3.3
#	2.1.2.3.5
#
# CCERef#:
#	CCE-4218-4
#
class yum {

	# GuideSection 2.1.2.3
	# Configure updates with yum
	file {
		"/etc/yum.repos.d":
			owner   => "root",
			group   => "root",
			mode    => 644,
			recurse => true,
			ignore  => "/etc/yum.repos.d";

		# GuideSection 2.1.2.3.2
		# Configure update retrieval and installation with cron
		"/etc/cron.daily/yum.cron":
			owner   => "root",
			group   => "root",
			mode    => 700,
			replace => false,
			source  => "puppet:///modules/yum/yum.cron";
	}

	exec {
		"yum.repos.d-mode":
			command => "chmod 0755 /etc/yum.repos.d",
			require => File["/etc/yum.repos.d"];

		# GuideSection 2.1.2.3.5
		# Ensure package signature checking is not disabled for any repo
		"/etc/yum.repos.d-gpgcheck":
			command => "sed -i 's/gpgcheck=0/gpgcheck=1/g' /etc/yum.repos.d/*",
			onlyif  => "/usr/bin/test `grep gpgcheck=0 *.repo | wc -l` -eq 0";
	}
	
	# GuideSection 2.1.2.3.3
	# Ensure package signature checking is globally activated
	augeas {
		"Yum.conf gpgcheck, 2.1.2.3.3":
			context => "/files/etc/yum.conf",
			lens	=> "yum.lns",
			incl    => "/etc/yum.conf",
			changes => "set main/gpgcheck 1";
	}

	# GuideSection 2.1.2.3.2
	# Disable the yum-updatesd service and replace it with the cron job
	service {
		"yum-updatesd":
			ensure  => false,
			enable  => false,
			require => File["/etc/cron.daily/yum.cron"];
	}
}
