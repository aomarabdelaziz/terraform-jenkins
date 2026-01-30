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


    stage('Terraform Init') {
      steps {
        withAWS(region: 'us-east-1', credentials: 'AWS_ROLE') {
          dir("projects/${params.PROJECT}/${params.ENV}") {
            sh 'terraform init'
          }
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withAWS(region: 'us-east-1', credentials: 'AWS_ROLE') {
          dir("projects/${params.PROJECT}/${params.ENV}") {
            sh 'terraform plan'
          }
        }
      }
    }

  } // end of stages
} // end of pipeline
