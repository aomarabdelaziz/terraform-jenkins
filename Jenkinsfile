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
        '''
      }
    }

    stage('Configure AWS') {
      steps {
        
         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'FINTECH_TEST_AWS_ACCESS']]) 
         {
          sh '''
            aws sts get-caller-identity
          '''
        }
      }
    }

  }
}
