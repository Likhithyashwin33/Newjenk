pipeline {
    agent any

    environment {
        IMAGE_NAME = "hello-world-flask"
        CONTAINER_NAME = "hello-world-container"
        PORT = "9001"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Checking out source code from Git...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image: ${IMAGE_NAME}"
                script {
                    // Remove old image if exists
                    bat "docker rmi -f ${IMAGE_NAME}:latest || exit 0"
                    // Build new image
                    bat "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "🚀 Running Docker container: ${CONTAINER_NAME} on port ${PORT}"
                script {
                    // Stop and remove old container if it exists
                    bat "docker rm -f ${CONTAINER_NAME} || exit 0"
                    // Run new container
                    bat "docker run -d -p ${PORT}:${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Wait for App (Preview)') {
            steps {
                echo "🌐 Waiting for app to stabilize (30s)... then open http://localhost:${PORT}"
                bat "timeout /t 30 /nobreak"
            }
        }
    }

    post {
        always {
            echo '🧹 Cleaning up old Docker containers...'
            script {
                bat "docker stop ${CONTAINER_NAME} || exit 0"
            }
        }
        success {
            echo "✅ Pipeline completed successfully! Visit http://localhost:${PORT}"
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
