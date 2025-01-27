packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu-server-24" {

  proxmox_url = "${var.proxmox_api_url}"
  username    = "${var.proxmox_api_token_id}"
  token       = "${var.proxmox_api_token_secret}"

  node    = "${var.node_name}"
  vm_name = "${var.vm_name}"
  vm_id   = "${var.vm_id}"

  template_description = "Ubuntu Server 24.04"

  insecure_skip_tls_verify = true

  scsi_controller = "virtio-scsi-pci"
  qemu_agent      = true

  boot_iso {
    type     = "scsi"
    iso_file = "local:iso/ubuntu-24.04.1-live-server-amd64.iso"
    # iso_url = "https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso"
    iso_storage_pool = "local"
    unmount          = true
    iso_checksum     = "sha256:e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"
  }

  unmount_iso = true  # Deprecated but added cause I can't seem to unmount the disk.

  cores   = "${var.cpu_cores}"
  sockets = "${var.cpu_sockets}"
  memory  = "${var.memory}"

  disks {
    type         = "virtio"
    disk_size    = "20G"
    storage_pool = "local-lvm"
    format       = "raw"
  }

  vga {
    type = "virtio"
  }

  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = "false"
  }

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]

  boot           = "c"
  boot_wait      = "6s"
  communicator   = "ssh"
  http_directory = "./http"

  ssh_username           = "${var.ssh_username}"
  ssh_password           = "${var.ssh_password}"
  ssh_timeout            = "20m"
  ssh_pty                = true
  ssh_handshake_attempts = 15

}

build {

  name = "ubuntu-server-24"
  sources = [
    "proxmox-iso.ubuntu-server-24"
  ]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo syapt update"
    ]
  }

}