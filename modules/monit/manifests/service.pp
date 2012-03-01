# Class: monit::service
#
# This module manages monit::service
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
class monit::service {

        service {"monit":
                ensure    => true,
                enable    => true,
                hasstatus => true,
                hasrestart => true, }




}
