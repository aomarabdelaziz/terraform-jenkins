pipeline {

  ansiColor('xterm') {
      sh 'echo "\033[32mSUCCESS\033[0m"'
  }

  agent {
    docker {
      image 'summerwind/actions-runner:ubuntu-22.04'
      args '-u root:root'
    }
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
          which terraform || (curl -fsSL https://releases.hashicorp.com/terraform/1.6.3/terraform_1.6.3_linux_amd64.zip -o terraform.zip && unzip terraform.zip && mv terraform /usr/local/bin/ && rm terraform.zip)
          which aws || (curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip && unzip -o awscliv2.zip && ./aws/install)
          which kubectl || (curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl && install kubectl /usr/bin/kubectl)
          which helm || (curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash)
        '''
      }
    }
  }
}
