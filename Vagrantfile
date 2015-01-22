Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.network "forwarded_port", guest: 9292, host: 9292
  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
end