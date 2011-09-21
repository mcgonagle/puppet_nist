# Module: automnt
#
# Class: automnt
#
# Description:
#	This class attempts to disable automounting of file systems through
#	the autofs service and through the gnome configuration files.
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
#	2.2.2.3
#	2.2.2.4
#
# CCERef#:
#	None
#
class automnt {
	# GuideSection 2.2.2.3
	# Disable automounter
	service {
		"autofs":
			ensure    => false,
			enable    => false,
			hasstatus => true,
		}	

	# GuideSection 2.2.2.4
	# Disable gnome automounting
	# Requires a log-out to see changes through:
	#   gconftool-2 -R /desktop/gnome/volume_manager
	exec {

		"Gnome automount_media, 2.2.2.4":
			command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/volume_manager/automount_media false",
			onlyif  => "/usr/bin/test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /desktop/gnome/volume_manager/automount_media | grep false | wc -l` -eq 0",
			user    => "root";

		"Gnome automount_drivers, 2.2.2.4":
			command => "/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/volume_manager/automount_drives false",
			onlyif  => "/usr/bin/test `/usr/bin/gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --get /desktop/gnome/volume_manager/automount_drives | grep false | wc -l` -eq 0",
			user    => "root";
	}
}
