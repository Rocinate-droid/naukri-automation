pipeline {
    agent any
    environment {
        CV_EMAIL = credentials('naukri-login')
    }
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
                sh '''
                echo $WORKSPACE
                mvn compile
                mvn test -Demail=$CV_EMAIL_USR -Dpassword=$CV_EMAIL_PSW
                mvn clean
                '''
            }
        }
   }
}

