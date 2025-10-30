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
                echo 'Installing dependencies...'
                sh 'python3 -m venv venv'
                sh '. venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt'
            }
        }

        stage('Run Flask App') {
            steps {
                echo 'Running Flask app on localhost:5000...'
                sh '. venv/bin/activate && nohup python app.py &'
                sh 'sleep 5'  // Give it a few seconds to start
                sh 'curl http://127.0.0.1:5000'  // Check if it responds
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'pkill -f app.py || true'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
