Vagrant::Config.run do |config|
    # Every Vagrant virtual environment requires a box to build off of. 
    #config.vm.box = "puppet_nist"
    config.vm.box = "puppet_nist3"
    #
    config.vm.boot_mode = :gui
    # Forward the SSH port. The 'forward_port_key' should match the
    # name of the forwarded port.
    ##config.ssh.forwarded_port_key = "ssh"
    config.ssh.guest_port = "22"
    config.ssh.port = "2223"
    config.ssh.private_key_path = "keys/vagrant"


    config.vm.forward_port(22, 2223)
    config.vm.forward_port(80, 8080)
    config.vm.forward_port(3000, 3000)
    config.vm.forward_port(8140, 8140)
    config.vm.forward_port(8000, 8000)
    config.vm.forward_port(2812, 2812)
end
