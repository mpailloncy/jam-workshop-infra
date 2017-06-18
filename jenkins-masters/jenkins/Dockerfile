FROM jenkinsci/jenkins:lts-alpine

RUN /usr/local/bin/install-plugins.sh \ 
	workflow-job:2.11 \
	workflow-aggregator:2.5	\
	pipeline-stage-view:2.8	\
	workflow-multibranch:2.15	\
	pipeline-utility-steps:1.3.0	\
	pipeline-model-definition:1.1.6	\
	blueocean:1.1.1	\
	github-branch-source:2.0.6	\
	cloudbees-bitbucket-branch-source:2.1.2	\
	digitalocean-plugin:0.12	\
	ssh-agent:1.15	\
	buildtriggerbadge:2.8.1 \
	pipeline-maven:2.5.0 \
	sonar:2.6.1 \
	greenballs:1.15

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/init.groovy

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"
