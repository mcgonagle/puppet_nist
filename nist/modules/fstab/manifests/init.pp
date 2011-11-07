# Module: fstab
#
# Class: fstab
#
# Description:
#	This class ensures potentially dangerous partitions are mounted with
#	restrictive options.
#
# Defines:
#	set-mount-options( $fstype, $option ) - for setting a mount option on all of a specific file
#	system type in the fstab
#
# Variables:
#	fstype
#	option
#
# Facts:
#	None
#
# LinuxGuide:
#	2.2.1.1
#	2.2.1.2
#	3.13.3.2
#
# CCERef#:
#	CCE-4249-9
#	CCE-4024-6
#	CCE-4368-7
#	CCE-4526-0
#
# TODO:
#	Determine how to isolate removable partitions locally mounted.
#
class fstab {
	# GuideSection 2.2.1.1
	# Add nodev option to Non-Root Local Partitions
	augeas {
		"fstab-non-root-nodev" :
			context => "/files/etc/fstab/*[file != '/'][count(opt[. = 'nodev']) = 0]",
			lens    => "fstab.lns",
			incl    => "/etc/fstab",
			changes => [
				"ins opt after opt[last()]",
				"set opt[last()] nodev",
			],
			onlyif	=> "match /files/etc/fstab/*[file != '/'][count(opt[. = 'nodev']) = 0] size > 0";
	}

	set-mount-options {
		# GuideSection 2.2.1.2
		# Add nodev, nosuid, and noexec Options to Removable Storage Partitions
		# Not yet implemented
		
		# GuideSection 3.13.3.2
		# Add nosuid option to Remote Media Partitions
		"nfs_nosuid":
			fstype => "nfs",
			option => "nosuid";

		# Add noexec option to Remote Media Partitions
		"nfs_noexec":
			fstype => "nfs",
			option => "noexec";

		# Add nodev option to Remote Media Partitions
		### Handled by GuideSection 2.2.1.1 ###
	}

	#########################################
	# Function: set-mount-options()
	#
	# Description:
	#	This define adds options ($option) to filesystems ($fstype) in /etc/fstab
	#
	# Parameters:
	#	$fstype: Modify lines with this file type
	#	$option: Add this option
	#
	# Returns:
	#	None
	#########################################
	define set-mount-options($fstype,$option) {
		augeas {
			"fstab-$fstype-$option":
				context => "/files/etc/fstab/*[vfstype = '$fstype'][count(opt[. = '$option']) = 0]",
				lens    => "fstab.lns",
				incl    => "/etc/fstab",
				changes => [
					"ins opt after opt[last()]",
					"set opt[last()] $option"
				],
				onlyif	=> "match /files/etc/fstab/*[vfstype = '$fstype'][count(opt[. = '$option']) = 0] size > 0";
		}
	}
}
