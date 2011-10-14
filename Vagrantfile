Vagrant::Config.run do |config|
    # Every Vagrant virtual environment requires a box to build off of. 
    config.vm.box = "puppet_nist"
    #
    config.vm.boot_mode = :gui
    # Forward the SSH port. The 'forward_port_key' should match the
    # name of the forwarded port.
    config.ssh.forwarded_port_key = "ssh"
    config.ssh.private_key_path = "keys/vagrant"
    config.vm.forward_port("ssh", 22, 2223)
    config.vm.forward_port("web", 80, 8080)
    config.vm.forward_port("dashboard", 3000, 3000)
    config.vm.forward_port("pe-httpd", 8140, 8140)
    config.vm.forward_port("splunk", 8000, 8000)
    config.vm.forward_port("monit", 2812, 2812)
end
