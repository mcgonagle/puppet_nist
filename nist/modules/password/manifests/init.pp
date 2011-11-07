# Module: password
#
# Class: password
#
# Description:
#	This class sets some general password settings, such as appropriate
#	permissions on shadow & passwd, password expiration parameters,
#	password algorithm as sha512, and other maintenance tasks.
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
#	checkUsers.bash
#	libuser.conf.erb
#
# LinuxGuide:
#	2.2.3.1
#	2.3.1.4
#	2.3.1.5
#	2.3.1.6
#	2.3.1.7
#	2.3.3.5
#
# CCERef#:
#	CCE-3932-1
#	CCE-3967-7
#	CCE-3883-6
#	CCE-4064-2
#	CCE-4130-1
#	CCE-3495-9
#	CCE-3918-0
#	CCE-3988-3
#	CCE-4210-1
#	CCE-3566-7
#	CCE-3958-6
#	CCE-3276-3
#	CCE-4092-3
#	CCE-4180-6
#	CCE-4154-1
#	CCE-4097-2
#	CCE-3987-5
#	CCE-4238-2
#	CCE-4009-7
#
class password {
	# GuideSection 2.2.3.1
	# Verify permissions on password related files
	file {
		"/etc/passwd":
			owner => "root",
			group => "root",
			mode  => 644;
		"/etc/group":
			owner => "root",
			group => "root",
			mode  => 644;
		"/etc/shadow":
			owner => "root",
			group => "root",
			mode  => 400;
		"/etc/gshadow":
			owner => "root",
			group => "root",
			mode  => 400;
		"/etc/libuser.conf":
			owner   => "root",
			group   => "root",
			mode    => 644,
			content => template("password/libuser.conf.erb");

		# GuideSection 2.3.1.4
		# Block Shell and Login Access for Non-Root System Accounts
		"/etc/puppet/scripts":
			ensure => directory,
			owner  => "root",
			group  => "root",
			mode   => 700;
		"/etc/puppet/scripts/checkUsers.bash":
			owner  => "root",
			group  => "root",
			mode   => 700,
			source => "puppet:///modules/password/checkUsers.bash";
	}	
	
	exec {
		# GuideSection 2.3.1.7
		# Password expiration
		"passmaxdays":
			command => "/bin/sed -i 's/PASS_MAX_DAYS[ \t]*[0-9][0-9]*/PASS_MAX_DAYS\t60/g' /etc/login.defs";
		"passmindays":
			command => "/bin/sed -i 's/PASS_MIN_DAYS[ \t]*[0-9][0-9]*/PASS_MIN_DAYS\t7/g' /etc/login.defs";
		"passminlength":
			command => "/bin/sed -i 's/PASS_MIN_LEN[ \t]*[0-9][0-9]*/PASS_MIN_LEN\t8/g' /etc/login.defs";
	
		# GuideSection 2.3.3.5
		# Upgrade password hashing algorithm
		"/usr/sbin/authconfig --passalgo=sha512 --update":
			user   => "root",
			onlyif => "/usr/bin/test `/bin/grep PASSWDALGORITHM=sha512 /etc/sysconfig/authconfig | /usr/bin/wc -w` -eq 0";

		# GuideSection 2.3.1.5
		# Verify that no accounts have empty Password Fields
		"/bin/awk -F: '(\$2 == \"\") {print}' /etc/shadow":
			user      => "root",
			logoutput => true;

		# GuideSection 2.3.1.6
		# Verify that No Non-Root Accounts Have UID 0
		"/bin/awk -F: '(\$3 == \"0\" && \$1 !=\"root\") {print}' /etc/passwd":
			user      => "root",
			logoutput => true;

		# GuideSection 2.3.1.4
		# Block Shell and Login Access for Non-Root System Accounts
		"/etc/puppet/scripts/checkUsers.bash":
			user      => "root",
			logoutput => true,
			require   => File["/etc/puppet/scripts/checkUsers.bash"];
	}
}
