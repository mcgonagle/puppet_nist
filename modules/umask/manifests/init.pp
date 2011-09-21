# Module: umask
#
# Class: umask
#
# Description:
#	Sets global umask settings.
#
# Defines:
#	umask-replace( $file )
#
# Variables:
#	file
#
# Facts:
#	None
#
# LinuxGuide:
#	2.2.4.1
#	2.3.4.4
#
# CCERef#:
#	CCE-4220-0
#	CCE-3844-8
#	CCE-3870-3
#	CCE-4227-5
#
# Notes:
#	Any statement that uses the umask-replace function will fail to
#	add umask 077 to the file, but it will correct any already-present umask
#	by changing it to 077.
#
class umask {

	# GuideSection 2.2.4.1
	# CCE-4220-0
	augeas {
		"Set Daemon umask, #2.2.4.1":
			context => "/files/etc/sysconfig/init",
			lens    => "shellvars.lns",
			incl    => "/etc/sysconfig/init",
			changes => "set UMASK 027";
	}

	exec {
		# GuideSection 2.3.4.4-#2
		"/etc/login.defs-add-umask":
			command => "/bin/echo 'umask 077' >> /etc/login.defs",
			onlyif  => "/usr/bin/test `/bin/grep -i umask /etc/login.defs | /usr/bin/wc -w` -eq 0";

		# GuideSection 2.3.4.4
		# CCE-3870-3
		"/etc/profile-add-umask":
			command => "/bin/echo 'umask 077' >> /etc/profile",
			onlyif  => "/usr/bin/test `/bin/grep -i umask /etc/profile | /usr/bin/wc -w` -eq 0";
	}

	umask-replace {
		# GuideSection 2.3.4.4-#1
		"etc_profile":
			file => "/etc/profile";
		# CCE-3844-8
		"etc_bashrc":
			file => "/etc/bashrc";
		# CCE-4227-5
		"etc_csh.cshrc":
			file => "/etc/csh.cshrc";

		# GuideSection 2.3.4.4-#3
		"etc_csh.login":
			file => "/etc/csh.login";
		"etc_profile.d":
			file => "/etc/profile.d/*";

		# GuideSection 2.3.4.4-#4
		"root_bashrc":
			file => "/root/.bashrc";
		"root_bashprofile":
			file => "/root/.bash_profile";
		"root_cshrc":
			file => "/root/.cshrc";
		"root_tcshrc":
			file => "/root/.tcshrc";
		"/etc/login.defs":
			file => "/etc/login.defs";
	}

	#########################################
	# Function: umask-replace()
	#
	# Description:
	#	This define adds a umask setting to $file
	#
	# Parameters:
	#	$file: This is the file that will have its umask set
	#
	# Returns:
	#	None
	#########################################
	define umask-replace($file) {
		exec {
			"umask_replace_${file}":
				command => "/bin/sed -i -r 's/(umask)([ \t]*)[0-9]{3}/\1\2077/gi' $file",
				onlyif  => "/usr/bin/test `/bin/egrep -i '(umask|UMASK)[[:space:]]*[0-9]{3}' $file | /bin/egrep -v -i '(umask|UMASK)[[:space:]]*077' | /bin/wc -l` -ne 0";
		}
	}
}
