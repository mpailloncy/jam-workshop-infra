resource "digitalocean_droplet" "jenkins" {
    
    count = "${var.count}"
    
    image = "docker-16-04"
    name = "jenkins-${count.index + 1}"
    region = "lon1"
    size = "2gb"
    
    ssh_keys = [ "a4:03:fc:ac:6c:2b:28:f3:23:d3:91:5b:a5:e5:2d:2c" ]

    connection {
          user = "root"
          type = "ssh"
          private_key = "${var.ssh_private_key}"
          timeout = "1m"
    }

}

output "jenkins_IPs" {
  value = [ "${digitalocean_droplet.jenkins.*.ipv4_address}" ]
}
