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

  environment {
    AWS_REGION = "eu-west-1"
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

    stage('Configure AWS') {
      steps {
        
         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-prod']]) 
         {
          sh '''
            aws sts get-caller-identity
          '''
        }
      }
    }

  }
}
