node("${env.SLAVE}") {

  stage("Build"){
    /*
        Update file src/main/resources/build-info.txt with following details:
        - Build time
        - Build Machine Name
        - Build User Name
        - GIT URL: ${GIT_URL}
        - GIT Commit: ${GIT_COMMIT}
        - GIT Branch: ${GIT_BRANCH}

        Simple command to perform build is as follows:
        $ mvn clean package -DbuildNumber=$BUILD_NUMBER
    */
    sh "echo build artefact"
    checkout scm
    sh "/usr/local/maven/bin/mvn clean package '-DbuildNumber={BUILD_NUMBER}'"
  }

  stage("Package"){
    /*
        use tar tool to package built war file into *.tar.gz package
    */
    sh "echo package artefact"
    sh "tar -zcvf pipeline-alubouski.tar.gz target/*.war"
  }

  stage("Roll out Dev VM"){
    /*
        use ansible to create VM (with developed vagrant module)
    */
    sh "echo ansible-playbook createvm.yml ..."
    sh "ansible-playbook createvm.yml -vv"
  }

  stage("Provision VM"){
    /*
        use ansible to provision VM
        Tomcat and nginx should be installed
    */
    sh "echo ansible-playbook provisionvm.yml ..."
    sh "ansible-playbook provision.yml -vv"
  }

  stage("Deploy Artefact"){
    /*
        use ansible to deploy artefact on VM (Tomcat)
        During the deployment you should create file: /var/lib/tomcat/webapps/deploy-info.txt
        Put following details into this file:
        - Deployment time
        - Deploy User
        - Deployment Job
    */
    sh "echo ansible-playbook deploy.yml -e artefact=... ..."
    sh "ansible-playbook deploy.yml -vv"
  }

  stage("Test Artefact is deployed successfully"){
    /*
        use ansible to artefact on VM (Tomcat)
        During the deployment you should create file: /var/lib/tomcat/webapps/deploy-info.txt
        Put following details into this file:
        - Deployment time
        - Deploy User
        - Deployment Job
    */
    sh "echo ansible-playbook application_tests.yml -e artefact=... ..."
    sh "ansible-playbook application_tests.yml -vv"
    sh "sleep 10m"
  }

}

