# Module: logwatch
#
# Class: logwatch
#
# Description:
#	This class removes the daily logwatch cron job
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
#	2.6.1.6.2
#
# CCERef#:
#	None
#
class logwatch {
	# GuideSection 2.6.1.6.2
	# Disable logwatch if server exists
	exec {
		"/bin/rm /etc/cron.daily/0logwatch":
			onlyif => "/usr/bin/test -e /etc/cron.daily/0logwatch",
			user   => "root";
	}
}
