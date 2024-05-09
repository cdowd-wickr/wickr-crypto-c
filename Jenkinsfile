pipeline {
    agent any
    environment {
        ARTIFACTORY_URL = credentials('ARTIFACTORY_URL')
        ARTIFACTORY_USER = credentials('ARTIFACTORY_USER')
        ARTIFACTORY_PASS = credentials('ARTIFACTORY_PASS')
    }
    stages {
        stage('Build and Publish') {
            steps {
                sh './build_android_docker.sh --push'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
