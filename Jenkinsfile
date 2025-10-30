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
                '''
            }
        }
    }

}
