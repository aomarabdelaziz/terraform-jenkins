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
          which terraform || (curl -fsSL https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip -o terraform.zip && unzip terraform.zip && mv terraform /usr/local/bin/ && rm terraform.zip)
        '''
      }
    }

    stage('Configure AWS') {
      steps {
        
         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ROLE']]) 
         {
          sh '''
            aws sts get-caller-identity
          '''
        }
      }
    }

    stage('Terraform init') {
      steps {
        

         sh """
            cd projects/${params.PROJECT}/${params.ENV}
            terraform init
          """

      }
    }

    stage('Terraform Command') {
      steps {
        

         sh """
            cd projects/${params.PROJECT}/${params.ENV}
            terraform ${params.COMMAND}
          """
        
      }
    }
    
  }
}
