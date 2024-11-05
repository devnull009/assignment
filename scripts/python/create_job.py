import jenkinsapi

server = jenkinsapi.jenkins.Jenkins(baseurl='http://jenkins:8080', use_crumb=True)

job_name = "Bakery-App"

# Configure the pipeline script
config_xml = """
<flow-definition plugin="workflow-job">
    <definition class="org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition">
        <script>
pipeline {
    agent any

    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Clone repository') {
            steps {
                git 'https://github.com/igor-baiborodine/vaadin-demo-bakery-app.git'
            }
        }
        stage('Perform testing') {
            steps {
                sh '''mvn compile verify'''
            }
        }
        stage('Build docker image') {
            steps {
                sh '''docker build --rm -t bakery-app .'''
            }
        }
        stage('Run docker image') {
            steps {
                sh '''docker run --hostname bakeryapp --name bakery-app -d bakery-app'''
            }
        }
    }
}
        </script>
        <sandbox>true</sandbox>
    </definition>
    <triggers/>
    <disabled>false</disabled>
</flow-definition>
"""

# Create a new Jenkins Pipeline
job = server.create_job(jobname=job_name, xml=config_xml)

# Build the job
job = server.build_job(jobname=job_name)
