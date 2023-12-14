pipeline {
    agent any
  environment { 
    
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-access-token') // jenkins에 등록해 놓은 docker hub credentials 이름
        
  }


    stages {
      stage('dockerhub check in'){
        steps{
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        }
      }

        stage('build') {
            steps {
                echo 'building the application...'
            }
        }
        stage('test') {
            steps {
                echo 'testing the application...'
            }
        }
        stage('deploy') {
            steps {
                echo 'deploying the application...'
            }
        }
    }
}