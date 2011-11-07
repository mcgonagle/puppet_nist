# Module: nfs
#
# Class: nfs
#
# Description:
#	This module ensures nfs-related services are not running and disabled at
#	startup.
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
#	3.13.1.1
#	3.13.1.2
#	3.13.1.3
#	3.13.3.1
#
# CCERef#:
#	CCE-4396-8
#	CCE-3535-2
#	CCE-3568-3
#	CCE-4533-6
#	CCE-4550-0
#	CCE-4491-7
#	CCE-4473-5
#
class nfs {
	# GuideSection 3.13
	# NFS and RPC	

	service {
		# GuideSection 3.13.1.1
		# disable nfs services
		"nfslock":
			ensure    => false,
			enable    => false,
			hasstatus => true;
		"rpcgssd":
			ensure    => false,
			enable    => false,
			hasstatus => true;
		"rpcidmapd":
			ensure    => false,
			enable    => false,
			hasstatus => true;

		# GuideSection 3.13.1.2
		"netfs":
			ensure    => false,
			enable    => false,
			hasstatus => true;

		# GuideSection 3.13.1.3
		"portmap":
			ensure    => false,
			enable    => false,
			hasstatus => true;

		# GuideSection 3.13.3.1
		"nfs":
			ensure    => false,
			enable    => false,
			hasstatus => true;
		"rpcsvcgssd":
			ensure    => false,
			enable    => false,
			hasstatus => true;
	}
}
