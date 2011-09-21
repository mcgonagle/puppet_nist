# Module: screenlock
#
# Class: screenlock
#
# Description:
#	This class installs and sets up screenlock (may require a reboot/logoff
#	to become effective)
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
#	2.3.5.6.1
#	2.3.5.6.2
#
# CCERef#:
#	CCE-3315-9
#	CCE-3910-7
#
class screenlock {
	# GuideSection 2.3.5.6
	# Configure screen locking

	# install vlock for console only
	package {
		"vlock":
			ensure => installed;
	}
	
	# GUI screen locking
	exec {
		"IdleActivation, 2.3.5.6":
			command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/idle_activation_enabled true",
			onlyif  => "/usr/bin/test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/idle_activation_enabled | grep true | wc -l` -eq 0",
			user    => "root";

		"LockEnabled, 2.3.5.6":
			command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/lock_enabled true",
			onlyif  => "/usr/bin/test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/lock_enabled | grep true | wc -l` -eq 0",
			user    => "root";

		"BlankOnly, 2.3.5.6":
			command =>"/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /apps/gnome-screensaver/mode blank-only",
			onlyif  => "/usr/bin/test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/mode | grep blank-only | wc -l` -eq 0",
			user    => "root";

		"IdleDelay, 2.3.5.6":
			command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set /apps/gnome-screensaver/idle_delay 15",
			onlyif  =>"/usr/bin/test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /apps/gnome-screensaver/idle_delay | egrep ^[0-9]*$` -lt 15",
			user    => "root";
	}
}
