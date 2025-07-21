pipeline {
    agent any
    environment {
        CV_EMAIL = credentials('naukri-login')
    }
        stage('execute') {
            steps {
                sh '''
                mvn compile
                mvn test -Demail=$CV_EMAIL_USR -Dpassword=$CV_EMAIL_PSW
                mvn clean
                '''
            }
        }
}

