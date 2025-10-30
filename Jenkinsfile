pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Setting up Python virtual environment...'
                bat '''
                python -m venv venv
                call venv\\Scripts\\activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Flask App (Keep Alive for 120s)') {
            steps {
                echo 'Starting Flask app and keeping Jenkins running for 120 seconds...'
                bat '''
                call venv\\Scripts\\activate
                start /B python app.py
                echo Flask app started on http://127.0.0.1:5000
                echo Waiting for 120 seconds...
                powershell -Command "Start-Sleep -Seconds 120"
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Flask process...'
            bat '''
            taskkill /F /IM python.exe || echo No Python process found
            '''
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
