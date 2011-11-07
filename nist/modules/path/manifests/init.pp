# Module: path
#
# Class: path
#
# Description:
#	This class attempts to check for dots or empty elements in root's path.
#	It does a fairly decent job, but is not 100% error proof. Some
#	elements are added to the path after login from other services that
#	the script cannot check. This will catch things added in .bashrc and
#	.bash_profile.
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
#	checkRootPath.bash.erb
#
# LinuxGuide:
#	2.3.4.1
#
# CCERef#:
#	CCE-3301-9
#
# TODO:
#	echo $PATH returns an extra item '/usr/X11R6/bin':
#	Find out when this item is added and see if puppet can coax this
#	script into running after that and similar scripts have been added.
#
class path {

	# GuideSection 2.3.4.1
	# This template greps for a dot (.) or empty set (::) in root's $PATH
	file {
		"/etc/puppet/scripts/checkRootPath.bash":
			owner   => "root",
			group   => "root",
			mode    => 755,
			content => template("path/checkRootPath.bash.erb");
	}
	
	exec {
		"/etc/puppet/scripts/checkRootPath.bash":
			command   => "/bin/su -lc /etc/puppet/scripts/checkRootPath.bash",
			logoutput => true,
			require   => File["/etc/puppet/scripts/checkRootPath.bash"];
	}
	# Note: Originally ran this exec with "user => root" instead of su, but
	# puppet documentation said error output will not be captured correctly
	# see http://docs.puppetlabs.com/references/stable/type.html#exec
}
