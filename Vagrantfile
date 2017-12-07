# -*- mode: ruby -*-
# vi: set ft=ruby :

# Defining Oracle Proxy / Use Case Flags
load './vagrant-addons/ProxyConfigfile'

# Plugin installation procedure from http://stackoverflow.com/a/28801317
# This will load by default proxyconf to allow the client access to the proxy.
required_plugins = %w(vagrant-proxyconf vagrant-disksize)
#
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end
# Completed Defining Some Oracle / Use Case Flags

# Display Message so users know how to access the demo.
$msg = <<MSG_EOF
------------------------------------------------------
Vagrant Web Server / Load Balancer, accessible at localhost (127.0.0.1)

List:
- C:\> vagrant status
Access:
- C:\> vagrant ssh loadbalancer
- C:\> vagrant ssh webserver1
- C:\> vagrant ssh webserver2
- C:\> vagrant ssh webserver3

- Load Balancer running at http://127.0.0.1:8080
  Reload to cycle through each Web Server
------------------------------------------------------
MSG_EOF

##############################################################################
WEBSERVER_NODE_COUNT = 3

Vagrant.configure("2") do |config|

  # This demo will use Oracle Linux 7 server image.

  # You can search for boxes from the Vagrant Cloud at https://vagrantcloud.com/search
  # config.vm.box = "oravirt/ol73"
  # config.vm.box = "oravirt/ol74"

  # or Oracle Linux boxes at http://yum.oracle.com/boxes
  config.vm.box_url = "http://yum.oracle.com/boxes/oraclelinux/ol74/ol74.box"
  config.vm.box = "ol74"

  # Share an additional folder to the guest VM, default is "share" in the current directory.
  config.vm.synced_folder "vagrant-share", "/vagrant-share"

  # Enable provisioning of the client with a shell script.
  config.vm.provision "shell", path: "./vagrant-shell/provision.sh"

  config.vm.define "loadbalancer" do |loadbalancer|
    loadbalancer.vm.hostname = "loadbalancer"
    # Skip IP .1 for possible router conflicts
    loadbalancer.vm.network "private_network", ip: "192.168.56.2"
    loadbalancer.vm.network "forwarded_port", guest: 80, host: 8080
    loadbalancer.vm.provision "shell", path: "./vagrant-shell/nginx.sh"
    loadbalancer.vm.provision "shell", path: "./vagrant-shell/nginx-loadbalancer.sh"
  end

  (1..WEBSERVER_NODE_COUNT).each do |i|
    config.vm.define "webserver#{i}" do |webserver|
      webserver.vm.hostname = "webserver#{i}"
      webserver.vm.network "private_network", ip: "192.168.56.#{i+2}"
      webserver.vm.provision "shell", path: "./vagrant-shell/nginx.sh"
    end
  end

end
