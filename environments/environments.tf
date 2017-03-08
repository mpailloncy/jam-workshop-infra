resource "digitalocean_droplet" "staging" {

    count = "${var.count}"

    image = "docker-16-04"
    name = "staging-${count.index + 1}"
    region = "lon1"
    size = "512mb"

    ssh_keys = [ "56:4f:3a:5e:88:7b:26:4a:68:8f:b3:25:17:71:19:88" ]

    connection {
          user = "root"
          type = "ssh"
          private_key = "${var.ssh_private_key}"
          timeout = "1m"
    }

}


output "staging-IPs" {
  value = [ "${digitalocean_droplet.staging.*.ipv4_address}" ]
}


resource "digitalocean_droplet" "prod" {

  count = "${var.count}"

  image = "docker-16-04"
  name = "prod-${count.index + 1}"
  region = "lon1"
  size = "512mb"

  ssh_keys = [ "56:4f:3a:5e:88:7b:26:4a:68:8f:b3:25:17:71:19:88" ]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${var.ssh_private_key}"
    timeout = "1m"
  }

}

output "prod-IPs" {
  value = [ "${digitalocean_droplet.prod.*.ipv4_address}" ]
}
