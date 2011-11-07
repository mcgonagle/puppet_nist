# Module: rpmverify
#
# Class: rpmverify
#
# Description:
#	Sets up a cron job to routinely scan the system for files that rpm -qVa
#	can pick out as different than expected. These files should be diagnosed
#	to see why they changed from expected values.
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
#	rpmverify.cron
#
# LinuxGuide:
#	2.1.3.1.1
#	2.1.3.1.3
#	2.1.3.1.4
#
# CCERef#:
#	CCE-4209-3
#
class rpmverify {
	# GuideSection 2.1.3.2
	# Verify package integrity via rpm
	file {
		"/etc/cron.daily/rpmverify.cron":
			owner  => "root",
			group  => "root",
			mode   => 755,
			source => "puppet:///modules/rpmverify/rpmverify.cron",
	}
}
