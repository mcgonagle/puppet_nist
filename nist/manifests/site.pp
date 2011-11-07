# /etc/puppet/manifests/site.pp

import "settings.pp"

# filebucket
filebucket { main: server => "puppet.example.com" }

# global defaults
File { backup => main}
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

import "nodes/*.pp"
