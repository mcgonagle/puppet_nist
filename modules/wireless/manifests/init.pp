# Module: wireless
#
# Class: wireless
#
# Description:
#	This class disables the wireless kernel modules.
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
#	2.5.2.2.3
#
# CCERef#:
#	CCE-4170-7
#
class wireless {
	# GuideSection 2.5.2.2.3
	# CCE-4170-7
	# Disable wireless drivers
	exec {
		"Disable wireless wireless modules, 2.5.2.2.3":
			command => "/usr/bin/find /lib/modules/*/wireless/drivers/net/wireless | /bin/grep ko$ | /usr/bin/xargs -I {} /bin/basename {} .ko | /bin/sort | /bin/uniq | /usr/bin/xargs -I {} /bin/echo 'install {} /bin/true' > /etc/modprobe.d/wireless-disable",
			user    => "root";
	}
}
