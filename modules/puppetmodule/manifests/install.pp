# Class: puppetmodule::install
#
# This module manages puppetmodule
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
class puppetmodule::install {
  package {"puppet-module": 
    ensure => installed,
    provider => gem, }


}
