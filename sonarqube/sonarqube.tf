resource "digitalocean_droplet" "sonarqube" {
    
    count = "${var.count}"
    
    image = "docker-16-04"
    name = "sonarqube-${count.index + 1}"
    region = "lon1"
    size = "2gb"
    
    ssh_keys = [ "56:4f:3a:5e:88:7b:26:4a:68:8f:b3:25:17:71:19:88" ]

    connection {
          user = "root"
          type = "ssh"
          private_key = "${var.ssh_private_key}"
          timeout = "1m"
    }

}

output "sonarqube_IPs" {
  value = [ "${digitalocean_droplet.sonarqube.*.ipv4_address}" ]
}
