resource "digitalocean_droplet" "staging" {

    count = "${var.count}"

    image = "docker-16-04"
    name = "staging-${count.index + 1}"
    region = "lon1"
    size = "512mb"

    ssh_keys = [ "84:e9:bc:7d:01:63:cc:f4:96:41:71:50:8c:0a:e6:4e" ]

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

  ssh_keys = [ "84:e9:bc:7d:01:63:cc:f4:96:41:71:50:8c:0a:e6:4e" ]

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