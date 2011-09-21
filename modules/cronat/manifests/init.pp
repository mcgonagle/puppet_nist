# Module: cronat
#
# Class: cronat
#
# Description:
#	This class configures the cronat process
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
#	3.4
#	3.4.2
#	3.4.3
#
# CCERef#:
#	CCE-4324-0
#	CCE-4304-2, CCE-3833-1, CCE-3604-6, CCE-3626-9, CCE-4022-0
#	CCE-3851-3, CCE-3481-9, CCE-4322-4, CCE-4203-6, CCE-4379-4
#	CCE-4054-3, CCE-4441-2, CCE-4250-7, CCE-4331-5, CCE-4106-1
#	CCE-4450-3, CCE-4388-5, CCE-3983-4, CCE-4380-2, CCE-4212-7,
#	CCE-4251-5
# TODO:
#	Use run stage to make sure this is one of the last things run.
#
class cronat {
	# GuideSection 3.4
	# CCE-4324-0
	# Configure cron and at daemons	
	service {
		"crond":
			ensure     => true,
			enable     => true,
			hasstatus  => true,
			hasrestart => true;

		# GuideSection 3.4.3
		# Disable at
		"atd":
			ensure     => false,
			enable     => false,
			hasstatus  => true,
			hasrestart => true;
	}

	# GuideSection 3.4.2
	# CCE-4304-2, CCE-3833-1, CCE-3604-6, CCE-3626-9, CCE-4022-0
	# CCE-3851-3, CCE-3481-9, CCE-4322-4, CCE-4203-6, CCE-4379-4
	# CCE-4054-3, CCE-4441-2, CCE-4250-7, CCE-4331-5, CCE-4106-1
	# CCE-4450-3, CCE-4388-5, CCE-3983-4, CCE-4380-2, CCE-4212-7,
	# CCE-4251-5
	# Restrict permissions on cron files
	file {
		"/etc/crontab":
			owner => "root",
			group => "root",
			mode  => 600;
		"/etc/anacrontab":
			owner => "root",
			group => "root",
			mode  => 600;
		"/etc/cron.hourly":
			owner => "root",
			group => "root",
			mode  => 700;
		"/etc/cron.daily":
			owner => "root",
			group => "root",
			mode  => 700;
		"/etc/cron.weekly":
			owner => "root",
			group => "root",
			mode  => 700;
		"/etc/cron.monthly":
			owner => "root",
			group => "root",
			mode  => 700;
		"/etc/cron.d":
			owner => "root",
			group => "root",
			mode  => 700;
		"/var/spool/cron":
			owner => "root",
			group => "root",
			mode  => 600;
	}
}
