pipeline {
    agent any
      stages {
        stage('extract resume') {
            steps {
                sh '''
                aws s3 cp s3://resume-bucket-srj/srjresume ./
                mv srjresume srjresume.pdf
                '''
            }
        }
        stage('execute') {
            steps {
                 withCredentials([usernamePassword(credentialsId: 'naukri-login', usernameVariable: 'email', passwordVariable: 'password')]) {
        sh '''
            echo $WORKSPACE
            mvn compile
            xvfb-run -a mvn test -Demail=$email -Dpassword=$password
            mvn clean
        '''
    }
            }
        }
   }
}

