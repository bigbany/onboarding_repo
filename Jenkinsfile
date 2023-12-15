pipeline {
    agent any
    options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
  }

  environment { 
        DOCKERREPO = "bigbaby22/onboarding-repo"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-access-token') // jenkins에 등록해 놓은 docker hub credentials 이름
        DOCKERIMAGE = '' 
  }

    stages {

      stage('Print and Modify Variables') {
            steps {
                script {
                    // run.sh 스크립트의 경로 설정
                    def scriptPath = 'run_check.sh'

                    // 스크립트를 읽어옴
                    def scriptContent = readFile(scriptPath).trim()

                    // 변수 값 출력
                  sh  'echo "원래 변수 값: $HOOK_URL"'

                    // 변수 수정
                 //   scriptContent = scriptContent.replaceAll(/VAR_NAME=.+/, 'VAR_NAME="new_value"')

                    // 수정된 스크립트 내용 출력 (선택 사항)
                   // echo "수정된 스크립트 내용:\n$scriptContent"

                    // 수정된 스크립트를 파일에 다시 쓰기
                   // writeFile(file: scriptPath, text: scriptContent)

                    // 수정된 변수 값 출력
                   // echo "수정된 변수 값: $VAR_NAME"
                }
            }
        }
        ///

    //     stage('Building image') { 
    //       steps { 
    //           script { 
    //               sh "docker build -t $DOCKERREPO:$BUILD_NUMBER ."      
    //           }
    //       } 
    //   }

    //     stage('dockerhub check in'){
    //     steps{
    //     sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
    //     }
    //   }

    //    stage('Docker Push') {
    //         steps {
    //             script {
    //               sh 'docker push $DOCKERREPO:$BUILD_NUMBER'
    //         }
    //     }

    // }
    
    }
}


