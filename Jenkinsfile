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

        stage('Run Flask App (Keep Alive)') {
            steps {
                echo 'Starting Flask app and keeping Jenkins running...'
                bat '''
                call venv\\Scripts\\activate
                start python app.py
                echo Flask app started on http://127.0.0.1:5000
                echo Press "Abort" in Jenkins to stop the pipeline.
                timeout /t -1
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Flask app process...'
            bat '''
            taskkill /F /IM python.exe || echo No Python process found
            '''
        }
        aborted {
            echo 'Pipeline aborted — Flask server stopped.'
        }
        success {
            echo 'Pipeline finished successfully.'
        }
    }
}
