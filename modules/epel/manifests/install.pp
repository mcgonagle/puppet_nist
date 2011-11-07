# Class: epel::install
#
# This module manages epel
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class epel::install {
  package {"epel-release-5-4":
    ensure => installed,
    provider => rpm,
    source =>  "/vagrant/modules/epel/files/epel-release-5-4.noarch.rpm", }


}
