variable "proxmox_api_url" {
  type    = string
  default = "https://:8006/api2/json" # Your Proxmox IP Address
}
variable "proxmox_api_token_id" {
  type    = string
  default = "" # Api Token IDroot@pam!{packer-token}
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
  default   = ""
}

variable "node_name" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = "ubuntu-server-24.04"
}

variable "vm_id" {
  type    = number
  default = 202
}

variable "cpu_cores" {
  type    = number
  default = 1
}

variable "cpu_sockets" {
  type    = number
  default = 1
}

variable "memory" {
  type    = number
  default = 2048
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ssh_password" {
  type      = string
  sensitive = true
  default   = ""
}