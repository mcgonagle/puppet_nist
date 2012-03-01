# Class: monit::monitd
#
# This module manages monit::monitd
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
define monit::monitd(
 $owner = "",
 $group = "",
 $pid_file = '',
 $init_script = '',
 $total_mem = '90',
 $cpu_usage = '90'
) {

   $process_name = "${name}"
   $group = "system"


   file {"/etc/monit.d/${process_name}":
	content => template("monit/monit_d_process.erb"),
	owner => "${owner}", group => "${group}", mode => "0644",
	require => Package["monit"], }



}
