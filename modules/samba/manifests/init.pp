# Module: samba
#
# Class: samba
#
# Description:
#	Enables Samba packet signing for the Samba client to prevent
#	man-in-the-middle attacks.
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
#	3.18.2.10
#	3.18.2.11
#
# CCERef#:
#	TBD
#
class samba {
	# GuideSection 3.18.1
	# Disable Samba if possible
	service { "samba" :
		ensure => false,
		enable => false;
	}

	augeas {
		# GuideSection 3.18.2.10
		# Require Client SMB Packet Signing, if using smbclient
		"samba-client-signing":
			context => "/files/etc/samba/smb.conf/*[. = 'global']",
			lens     => "samba.lns",
			incl    => "/etc/samba/smb.conf",
			changes => "set 'client\ signing' mandatory",
			onlyif	=> "get 'client\ signing' != mandatory";
	
		# GuideSection 3.18.2.11
		# Require Client SMB Packet Signing, if using mount.cifs
		"cifs-client-signing" :
			context => "/files/etc/fstab/*[vfstype =~ regexp('(ci|smb)fs')][count(opt[. =~ regexp('sec=(krb5i|ntlmv2i)')]) = 0]",
			lens     => "fstab.lns",
			incl    => "/etc/fstab",
			changes => [
				"ins opt after opt[last()]",
				"set opt[last()] sec=krb5i"
			],
			onlyif	=> "match /files/etc/fstab/*[vfstype =~ regexp('(ci|smb)fs')][count(opt[. =~ regexp('sec=(krb5i|ntlmv2i)')]) = 0] size > 0";
	}
}
