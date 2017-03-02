FROM jenkins:2.32.2-alpine

RUN /usr/local/bin/install-plugins.sh \ 
	workflow-aggregator:2.5 \
	pipeline-stage-view:2.5 \
	workflow-multibranch:2.12 \
	pipeline-utility-steps:1.2.2 \
	pipeline-model-definition:1.0.2 \
	blueocean:1.0.0-b24 \
	blueocean-autofavorite:0.6 \
	blueocean-commons:1.0.0-b24 \
	blueocean-config:1.0.0-b24 \
	blueocean-dashboard:1.0.0-b24 \
	blueocean-display-url:1.5.1 \
	blueocean-events:1.0.0-b24 \
	blueocean-git-pipeline:1.0.0-b24 \
	blueocean-github-pipeline:1.0.0-b24 \
	blueocean-i18n:1.0.0-b24 \
	blueocean-jwt:1.0.0-b24 \
	blueocean-personalization:1.0.0-b24 \
	blueocean-pipeline-api-impl:1.0.0-b24 \
	blueocean-pipeline-editor:0.1-preview-4 \
	blueocean-rest:1.0.0-b24 \
	blueocean-rest-impl:1.0.0-b24 \
	blueocean-web:1.0.0-b24 \
	github-branch-source:2.0.3 \
	cloudbees-bitbucket-branch-source:2.1.0 \
	digitalocean-plugin:0.12 \
	ssh-agent:1.14 \
	buildtriggerbadge:2.8

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/init.groovy

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"
