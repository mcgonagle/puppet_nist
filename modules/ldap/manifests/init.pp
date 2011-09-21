# Module: ldap
#
# Class: ldap
#
# Description:
#	This class removes the openLdap server and edits the PAM ldap
#	configuration.
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
#	3.12.3.1
#
# CCERef#:
#	CCE-3501-4
#
class ldap {
	# GuideSection 3.12.3.1
	# Install OpenLDAP Server RPM(disabled)
	package {
		"openldap-servers":
			ensure => absent;
	}

	augeas {
		"ldap-tls":
			context => "/files/etc/ldap.conf",
			changes => "set tls_checkpeer yes";
	}
}
