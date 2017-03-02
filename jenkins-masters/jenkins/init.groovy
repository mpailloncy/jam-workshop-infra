import jenkins.model.*
import hudson.model.*
import hudson.security.*

def getMandatoryParameter(String parameterName) {
  def env = System.getenv()
  def value = env[parameterName]
  if(value == null || value.equals("")){
    println "[ERROR] Mandatory parameter ${parameterName} not found in environment variables. Killing Jenkins instance... Bye"
    System.exit(1)
  }
  return value
}

def hostname = getMandatoryParameter('hostname')
def adminUsername = getMandatoryParameter('admin_username')
def adminPassword = getMandatoryParameter('admin_password')
def numExecutors = getMandatoryParameter('master_numexecutors')

def digiOceanApiToken = getMandatoryParameter('digitalocean_api_token')
def digiOceanSshPrivateKey = getMandatoryParameter('digitalocean_ssh_private_key') 
def digiOceanSshKeyId = getMandatoryParameter('digitalocean_ssh_key_id')
def digiOceanRegion = getMandatoryParameter('digitalocean_region')
def digiOceanImageId = getMandatoryParameter('digitalocean_image_id')
def digiOceanIdleTerminationInMinutes = getMandatoryParameter('digitalocean_idle_termination_in_minutes')
def digiOceanInitScript = getMandatoryParameter('digitalocean_init_script')

def digiOceanNodeHeavyTaskLabels = getMandatoryParameter('digitalocean_node_heavy_tasks_labels')
def digiOceanNodeHeavyTasksSize = getMandatoryParameter('digitalocean_node_heavy_tasks_size_id')
def digiOceanNodeHeavyTasksNumexecutors = getMandatoryParameter('digitalocean_node_heavy_tasks_numexecutors')
def digiOceanNodeHeavyTasksCap = getMandatoryParameter('digitalocean_node_heavy_tasks_cap')

def digiOceanNodeLightTaskLabels = getMandatoryParameter('digitalocean_node_ligth_tasks_labels')
def digiOceanNodeLightTasksSize = getMandatoryParameter('digitalocean_node_ligth_tasks_size_id')
def digiOceanNodeLightTasksNumexecutors = getMandatoryParameter('digitalocean_node_ligth_tasks_numexecutors')
def digiOceanNodeLightTasksCap = getMandatoryParameter('digitalocean_node_ligth_tasks_cap')

def env = System.getenv()
def jenkinsUrl=env['jenkins_url']

if(jenkinsUrl == null || jenkinsUrl.isEmpty()) {
  jenkinsUrl="http://${hostname}:8080"
}

// master setup
Jenkins.instance.setNumExecutors(Integer.parseInt(numExecutors))
jlc = JenkinsLocationConfiguration.get()
jlc.setUrl(jenkinsUrl)
jlc.setAdminAddress("michael.pailloncy@gmail.com")
jlc.save()

// create admin Jenkins account
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(adminUsername, adminPassword)
Jenkins.instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
Jenkins.instance.setAuthorizationStrategy(strategy)

// auto install Maven
def mavenExtension = Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]
def mavenInstallationList = (mavenExtension.installations as List)
mavenInstallationList.add(new hudson.tasks.Maven.MavenInstallation('M3', null, [new hudson.tools.InstallSourceProperty([new hudson.tasks.Maven.MavenInstaller("3.3.9")])]))
mavenExtension.installations = mavenInstallationList
mavenExtension.save()

// add DigitalOcean cloud configuration
def cloudTemplates = [
	new com.dubture.jenkins.digitalocean.SlaveTemplate(
			"heavy.tasks.node", 
			digiOceanImageId, 
			digiOceanNodeHeavyTasksSize, 
			digiOceanRegion, 
			"root", 
			"/jenkins/",
			22,
			digiOceanIdleTerminationInMinutes, 
			digiOceanNodeHeavyTasksNumexecutors, 
			digiOceanNodeHeavyTaskLabels,
			digiOceanNodeHeavyTasksCap, 
			"",
			digiOceanInitScript
	),
	new com.dubture.jenkins.digitalocean.SlaveTemplate(
			"light.tasks.node", 
			digiOceanImageId, 
			digiOceanNodeLightTasksSize, 
			digiOceanRegion,
			"root", 
			"/jenkins/",
			22,
			digiOceanIdleTerminationInMinutes, 
			digiOceanNodeLightTasksNumexecutors, 
			digiOceanNodeLightTaskLabels,
			digiOceanNodeLightTasksCap, 
			"",
			digiOceanInitScript
		)
]

def digitalOcean = new com.dubture.jenkins.digitalocean.Cloud(
	"digitalocean.cloud", 
	digiOceanApiToken, 
	digiOceanSshPrivateKey, 
	digiOceanSshKeyId,

Jenkins.instance.clouds.replace(digitalOcean)
Jenkins.instance.save()