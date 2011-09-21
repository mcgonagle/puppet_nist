# Module: logrotate
#
# Class: logrotate
#
# Description:
#	This class installs ensures logrotate is rotating the specified files.
#
# Defines:
#	logrotate::changeParm( $name )
#
# Variables:
#	name
#
# Facts:
#	None
#
# LinuxGuide:
#	2.6.1.5
#
# CCERef#:
#	CCE-4182-2
#
class logrotate {
	# GuideSection 2.6.1.5
	# CCE-4182-2
	# Ensure all logs rotated

	logrotate::changeParm{"/var/log/messages":}
	logrotate::changeParm{"/var/log/kern.log":}
	logrotate::changeParm{"/var/log/daemon.log":}
	logrotate::changeParm{"/var/log/secure":}
	logrotate::changeParm{"/var/log/maillog":}
	logrotate::changeParm{"/var/log/cron":}
	logrotate::changeParm{"/var/log/syslog":}
	logrotate::changeParm{"/var/log/unused.log":}
}

#########################################
# Function: logrotate::changeParm()
#
# Description:
#	This define adds a line to /etc/logrotate.d/syslog to enable
#	log rotation for the given log file.
#
# Parameters:
#	$name: This is the log file that will have log rotation enabled.
#
# Returns:
#	None
#########################################
define logrotate::changeParm ( )
{
	augeas{
		"logrotate-$name":
			context => "/files/etc/logrotate.d/syslog",
			lens    => "logrotate.lns",
			incl    => "/etc/logrotate.d/syslog",
			changes => [
				"ins file before rule/file[1]",
				"set rule/file[1] $name",
			],
			onlyif =>"match *[file='$name'] size == 0",
	}
}
