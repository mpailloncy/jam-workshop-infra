#!/bin/bash

set -euo pipefail

rm -rf _dist
mkdir _dist

for i in environments jenkins-masters sonarqube
do
  filename=_dist/$( echo "infos-$i" | sed 's#/##g' )
  echo "processing $i => $filename"
  cd $i
    pwd
    make infos > ../$filename
  cd -
done

for n in $(seq 1 30)
do
  > _dist/$n.txt
  echo "Master Jenkins: "$( grep "jenkins-$n " _dist/infos-jenkins-masters ) >> _dist/$n.txt
  echo "Staging env: "$( grep "staging-$n " _dist/infos-environments ) >> _dist/$n.txt
  echo "Prod env: "$( grep "prod-$n " _dist/infos-environments ) >> _dist/$n.txt
done
