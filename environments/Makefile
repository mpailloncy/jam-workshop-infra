mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

# variables
n=1
machine=$(filter-out $@,$(MAKECMDGOALS))

plan:
	@terraform plan -var "do_token=${DO_API}" -var "count=$(n)"

provision:
	@terraform apply -var "do_token=${DO_API}" -var "count=$(n)" && sleep 10 && \
	export TERRAFORM_STATE_ROOT='.' && ansible-playbook -i terraform-inventory.py -e digitalocean_api_token="${DO_API}" environments-provisioning.yml

destroy:
	@terraform destroy -var "do_token=${DO_API}" -var "count=$(n)"

infos:
	@echo "#############################################"
	@echo "Machines infos :"
	@jq --raw-output '._meta.hostvars | to_entries[] | "\thost = " + .key + " " + .value.public_ipv4' <<< `export TERRAFORM_STATE_ROOT='.' &&  ./terraform-inventory.py --list --pretty`

go:
	@echo "Connecting to $(machine)"
	@ssh (current_dir)/../id_rsa_jam root@`jq --raw-output "._meta.hostvars[\"$(machine)\"] | .public_ipv4" <<< \`export TERRAFORM_STATE_ROOT='.' && ./terraform-inventory.py --list --pretty\``

