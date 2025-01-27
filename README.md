# packer-poc

Testing Packer to make templates for my proxmox homelab.

## ubuntu-server-24

packer config repo to build a proxmox ubuntu server 24.04

### usage

Go to the ```ubuntu-server-24``` directory, add your variables in the default values of the ```variables.pkr.hcl``` and build the config with ```packer build .```

</br></br>

Before building you can also validate your config with ```packer validate .```