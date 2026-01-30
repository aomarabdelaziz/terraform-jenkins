pipeline {

  agent {
    docker {
      image 'abdelazizomar/devops-utilites:latest'
      args '-u root:root'
    }
  }

  options {
    ansiColor('xterm')
  }


  
  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install Tools') {
      steps {
        sh '''
          set -e
          which aws || (curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip && unzip -o awscliv2.zip && ./aws/install)
          which terraform || (curl -fsSL https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip -o terraform.zip && unzip -o terraform.zip && mv terraform /usr/local/bin/ && rm terraform.zip)
        '''
      }
    }


  stage('Terraform Init') {
        steps {
          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ROLE']]) {
            dir("projects/${params.PROJECT}/${params.ENV}") {
              sh 'terraform init'
            }
          }
        }
      }

      stage('Terraform Plan') {
        steps {
          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ROLE']]) {
            dir("projects/${params.PROJECT}/${params.ENV}") {
              sh 'terraform plan'
            }
          }
        }
      }
  }
  
}
