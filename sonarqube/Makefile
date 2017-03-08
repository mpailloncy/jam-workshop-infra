mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

# variables
n=1
machine=$(filter-out $@,$(MAKECMDGOALS))

plan:
	@terraform plan -var "do_token=${DO_API}" -var "count=$(n)"

provision:
	@terraform apply -var "do_token=${DO_API}" -var "count=$(n)" && sleep 10 && \
	export TERRAFORM_STATE_ROOT='.' && ansible-playbook -i terraform-inventory.py -e digitalocean_api_token="${DO_API}" sonarqube-provisioning.yml

destroy:
	@terraform destroy -var "do_token=${DO_API}" -var "count=$(n)"

infos:
	@echo "#############################################"
	@echo "Machines infos :"
	@jq --raw-output '._meta.hostvars | to_entries[] | "\t " + .key + " :: login = admin password = admin url = http://" + .value.public_ipv4 + ":9000"' <<< `export TERRAFORM_STATE_ROOT='.' && ./terraform-inventory.py --list --pretty`
	 
logs:
	@echo "Displaying logs of $(machine)"
	@ssh -i $(current_dir)/../id_rsa_jam root@`jq --raw-output "._meta.hostvars[\"$(machine)\"] | .public_ipv4" <<< \`export TERRAFORM_STATE_ROOT='.' && ./terraform-inventory.py --list --pretty\`` -- docker logs -f sonarqube

go:
	@echo "Connecting to $(machine)"
	@ssh -i $(current_dir)/../id_rsa_jam root@`jq --raw-output "._meta.hostvars[\"$(machine)\"] | .public_ipv4" <<< \`export TERRAFORM_STATE_ROOT='.' && ./terraform-inventory.py --list --pretty\``
