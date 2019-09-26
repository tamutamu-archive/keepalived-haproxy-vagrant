# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vbguest.auto_update = true

  config.vm.boot_timeout = 600
  
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ""
    config.proxy.https    = ""
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.1.10,192.168.1.11,192.168.1.20,192.168.1.21,192.168.1.30,192.168.1.31,192.168.1.200"
  end

  ## config.ssh.private_key_path = "./ssh_key"
  config.ssh.insert_key = false
  
  config.vm.define :keep1 do |keep1|
    keep1.vm.box = "ubuntu/bionic64"
    keep1.vm.network :private_network, ip: "192.168.1.10"
    keep1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    keep1.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    keep1.vm.provision "shell" do |s|
      s.path = "scripts/install-keepalived.sh"
      s.args = "100"
    end
    ##
    ##config.vm.provision "file", source: "centos/keepalived.service.d", destination: "/tmp/"
    ##
    keep1.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :keep2 do |keep2|
    keep2.vm.box = "ubuntu/bionic64"
    keep2.vm.network :private_network, ip: "192.168.1.11"
    keep2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    keep2.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    keep2.vm.provision "shell" do |s|
      s.path = "scripts/install-keepalived.sh"
      s.args = "101"
    end

    ##config.vm.provision "file", source: "centos/keepalived.service.d", destination: "/tmp/"

    keep2.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :hap1 do |hap1|
    hap1.vm.box = "ubuntu/bionic64"
    hap1.vm.network :private_network, ip: "192.168.1.20"
    hap1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    hap1.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    hap1.vm.provision "shell" do |s|
      s.path = "scripts/install-haproxy.sh"
    end
    hap1.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :hap2 do |hap2|
    hap2.vm.box = "ubuntu/bionic64"
    hap2.vm.network :private_network, ip: "192.168.1.21"
    hap2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    hap2.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    hap2.vm.provision "shell" do |s|
      s.path = "scripts/install-haproxy.sh"
    end
    hap2.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :web1 do |web1|
    web1.vm.box = "ubuntu/bionic64"
    web1.vm.network :private_network, ip: "192.168.1.30"
    web1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1"]
    end
    web1.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    web1.vm.provision "shell" do |s|
      s.path = "scripts/install-app.sh"
      s.args = "Web1"
    end
    web1.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :web2 do |web2|
    web2.vm.box = "ubuntu/bionic64"
    web2.vm.network :private_network, ip: "192.168.1.31"
    web2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1"]
    end
    web2.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    web2.vm.provision "shell" do |s|
      s.path = "scripts/install-app.sh"
      s.args = "Web2"
    end
    web2.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end

  config.vm.define :jmeter do |jmeter|
    jmeter.vm.box = "ubuntu/bionic64"
    jmeter.vm.network :private_network, ip: "192.168.1.50"
    jmeter.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1324", "--cpus", "1"]
    end
    jmeter.vm.provision "shell" do |s|
      s.path = "scripts/common.sh"
    end
    jmeter.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end

end
