# -*- mode: ruby -*-
# vi: set ft=ruby :

# to make mananging ssh keys easier
# require_relative './vagrant/key_authorization'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
#
# Make virtualbox the default provider
#
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
#
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  #
  # Set up the vagrant hostmanager plugin to populate guests /etc/hosts file
  #
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  #
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"
  # authorize_key_for_root config, '~/.ssh/id_dsa.pub', '~/ssh/id_rsa.pub'
  #
  # Create the dev VM
  #
  config.vm.define :dev do |dev|
    # define the base box and OS
    dev.vm.box = "ubuntu/trusty64"
    # dev.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty32/versions/20160406.0.0/providers/virtualbox.box"
    #
    # Configure the network
    dev.vm.network :private_network, ip: "192.168.100.100"
    dev.vm.hostname = "dev.local"
    dev.ssh.forward_agent = true
    dev.hostmanager.aliases = %w(dev)
    #
    # Allow symlinks, set ram to 2gb (not)
    #
    dev.vm.provider :virtualbox do |vb|
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
      # vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
    #
    # Sync the /vagrant folder on the VM with this project directory
    dev.vm.synced_folder ".", "/vagrant"
    #
    # Initial provisioning for the vagrant VM
    #
    dev.vm.provision :shell, :path => "provisioning.sh"
  end
  #
  # Define App Target VMs
  #
  config.vm.define :mendix1 do |mendix1|
    mendix1.vm.box = "bento/centos-7.1"
    # mendix1.vm.box = "bento/centos-7.2"
    # mendix1.vm.box = "ubuntu/trusty64"
    mendix1.vm.network :private_network, ip: "192.168.100.101"
    mendix1.vm.network :forwarded_port, guest: 8000, host: 10101
    mendix1.vm.hostname = "mendix1.local"
    mendix1.vm.synced_folder ".", "/vagrant", disabled: true
    mendix1.ssh.forward_agent = true
    mendix1.hostmanager.aliases = %w(mendix1)
  end
  config.vm.define :mendix2 do |mendix2|
    mendix2.vm.box = "bento/centos-7.1"
    # mendix2.vm.box = "ubuntu/trusty64"
    mendix2.vm.network :private_network, ip: "192.168.100.102"
    mendix2.vm.network :forwarded_port, guest: 8000, host: 10102
    mendix2.vm.hostname = "mendix2.local"
    mendix2.vm.synced_folder ".", "/vagrant", disabled: true
    mendix2.ssh.forward_agent = true
    mendix2.hostmanager.aliases = %w(mendix2)
    # mendix2.vm.provider "virtualbox" do |g|
    	# g.gui = true
    # end
  end
  #config.vm.define :appdc do |appdc|
  #  appdc.vm.box = "bento/centos-7.2"
  #  appdc.vm.network :private_network, ip: "192.168.100.103"
  #  appdc.vm.network :forwarded_port, guest: 8090, host: 10103
  #  appdc.vm.hostname = "controller.local"
  #  appdc.ssh.forward_agent = true
  #  appdc.hostmanager.aliases = %w(controller)
  #
  #  appdc.vm.provider :virtualbox do |vb|
  #    #vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
  #    vb.customize ["modifyvm", :id, "--memory", "1024"]
  #  end
    #
  #end



  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
