variable "do_token" {}

variable "ssh_public_key" {
  type    = "string"
  default = "../id_rsa_jam.pub"
}

variable "ssh_private_key" {
  type    = "string"
  default = "../id_rsa_jam"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

variable "count" {
  default = 1
}
