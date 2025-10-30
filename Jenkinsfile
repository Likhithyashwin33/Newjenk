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
                echo 'Creating virtual environment and installing dependencies...'
                bat '''
                python -m venv venv
                call venv\\Scripts\\activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Flask App') {
            steps {
                echo 'Starting Flask app on localhost:5000...'
                bat '''
                call venv\\Scripts\\activate
                start /B python app.py
                timeout /T 5
                curl http://127.0.0.1:5000
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Kill the Python process if still running
            bat 'taskkill /F /IM python.exe || echo "No python process found"'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
