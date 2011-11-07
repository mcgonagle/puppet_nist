# Global Settings for puppet are stored in this file

$dns_server = "dns.$domain"

$ntpd_servers = [ "ntp.$domain" ]

$syslog_servers = [ "127.0.0.1" ]
$syslog_client_options = "-m 0"
$syslog_server_options = "-m 0 -r -s $domain"
