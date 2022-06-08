pipeline {
    environment {
        registry = "13.209.42.186:5000"
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
                    app = docker.build '13.209.42.186:5000/acmipc'
                }
            }
        }

        stage('Push-Image') {
            agent any
            steps {
                script {
                    docker.withRegistry("13.209.42.186:5000") {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}