pipeline {

 agent any

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }


    stage('terraform') {
      steps {
        script {
          docker.image('hashicorp/terraform').inside('-u root:root') {
            sh '''
                which kubectl || (curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl && install kubectl /usr/bin/kubectl)
                which helm || (curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash)
            '''
          }
        }
      }
    }

    stage('Install Tools') {
      steps {
        sh '''
          which kubectl || (curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl && install kubectl /usr/bin/kubectl)
          which helm || (curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash)
        '''
      }
    }

  }
}
