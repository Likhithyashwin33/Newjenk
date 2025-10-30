pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git checkout
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Run Application') {
            steps {
                echo "Starting Flask app on http://localhost:9001"
                bat 'start /B python app.py'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
