pipeline {
    environment {
        registry = "18.236.246.100:5000"
        registry_credentials = "registry-auth"
    }
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3.8.12-buster'
                    args '-u root:root'
                }
            }
            steps {
                sh 'pip install -r requirements.txt'
                sh 'pyinstaller -w -F src/acmipc.py'
                stash(name: 'built-binary', includes: 'dist/acmipc')
            }
            post {
                success {
                    archiveArtifacts "dist/acmipc"
                }
            }
        }

        stage('Build-Image') {
            agent any
            steps {
                script {
                    app = docker.build 'talma/acmipc'
                }
            }
        }

        stage('Push-Image') {
            agent any
            steps {
                script {
                    docker.withRegistry("18.236.246.100:5000", "registry-auth") {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}