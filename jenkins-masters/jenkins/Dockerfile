FROM jenkins:2.32.3-alpine

RUN /usr/local/bin/install-plugins.sh \ 
	workflow-aggregator:2.5 \
	pipeline-stage-view:2.6 \
	workflow-multibranch:2.13 \
	pipeline-utility-steps:1.2.2 \
	pipeline-model-definition:1.0.2 \
	blueocean:1.0.0-b25 \
	blueocean-pipeline-editor:1.0-alpha-4 \
	github-branch-source:2.0.4-beta-1 \
	cloudbees-bitbucket-branch-source:2.1.0 \
	digitalocean-plugin:0.12 \
	ssh-agent:1.14 \
	pipeline-maven:2.0-beta-6\
	sonar:2.6\
	buildtriggerbadge:2.8


COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/init.groovy

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"
