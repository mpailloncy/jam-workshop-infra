#!/bin/bash -eu

set -o pipefail
# set -o xtrace
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Simple bash script to retrieve latest version of Jenkins plugins listed in a "plugins-list.txt" file.

# Because it's so boring to retrieve all of them when you are creating a Dockerfile to launch Jenkins with plugins already installed:
# Example :  
#
# FROM jenkins:2.32.2-alpine
# RUN /usr/local/bin/install-plugins.sh \ 
# 	workflow-aggregator:2.5 \
# 	pipeline-stage-view:2.5 \
# 	workflow-multibranch:2.12 \
# 	pipeline-utility-steps:1.2.2 \
# 	pipeline-model-definition:1.0.2 \
# 	blueocean:1.0.0-b24 \
# 	cloudbees-bitbucket-branch-source:2.1.0 \
# 	digitalocean-plugin:0.12 \
# 	ssh-agent:1.14 \
# 	buildtriggerbadge:2.8
# 

# Sample input plugins-list.txt :
# 
# workflow-aggregator
# pipeline-stage-view
# workflow-multibranch
# pipeline-utility-steps
# pipeline-model-definition
# blueocean
# github-branch-source 
# cloudbees-bitbucket-branch-source
# digitalocean-plugin
# ssh-agent
# buildtriggerbadge
 
# Prerequisites : This script assumes that you have jq and curl installed locally

url="https://updates.jenkins.io/update-center.actual.json"
pluginListfile="${__dir}/plugins-list.txt"
[[ ! -f $pluginListfile ]] && echo "[ERROR] File listing target plugins not found : ${pluginListfile}. Please create it (one plugin id by line)." && exit 2

echo "Fetching latest plugins version from update center ..."

json=$(curl -sL ${url})
latestVersions=$(echo "${json}" | jq --raw-output '.plugins[] | .name + ":" + .version')

plugins=$(cat ${pluginListfile} | grep -vE '^(\s*$|#)')

echo ""
while read plugin; do
	
	result=$(echo "$latestVersions" | grep -E "^${plugin}:")
	if [[ "$?" == "0" ]]; then
		echo "${result}"
	else
		echo "[WARNING] Plugin ${plugin} not found "
	fi	

done <<< "${plugins}"
