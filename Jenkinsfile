pipeline {

  agent {
    docker {
      image 'summerwind/actions-runner:ubuntu-22.04'
      args '-u root:root'
    }
  }

  options {
    ansiColor('xterm')
  }

  parameters {
    string(name: 'PROJECT', defaultValue: '', description: 'Terraform project')
    string(name: 'ENV', defaultValue: '', description: 'Environment')
    string(name: 'COMMAND', defaultValue: 'plan', description: 'Terraform Plan Command')
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
        '''
      }
    }

    stage('Terraform init AWS') {
      steps {
        
         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ROLE']]) 
         {
         sh """
            cd projects/${params.PROJECT}/${params.ENV}
            terraform init
          """
        }
      }
    }

    stage('Terraform init AWS') {
      steps {
        
         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ROLE']]) 
         {
         sh """
            cd projects/${params.PROJECT}/${params.ENV}
            terraform ${params.COMMAND}
          """
        }
      }
    }

  }
}
