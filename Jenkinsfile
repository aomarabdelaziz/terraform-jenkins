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
          dir("projects/${params.PROJECT}/${params.ENV}") {
            sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withAWS(role:'PRODCrossAccountRole', roleAccount:'925880893941') {
          dir("projects/${params.PROJECT}/${params.ENV}") {
            sh 'terraform plan'
          }
        }
      }
    }

  } // end of stages
} // end of pipeline
