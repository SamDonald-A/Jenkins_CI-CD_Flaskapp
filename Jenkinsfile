pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    pip install pytest
                '''
            }
        }

        stage('Start MongoDB for Tests') {
            steps {
                sh '''
                    docker rm -f mongo-test || true
                    docker run -d --name mongo-test -p 27017:27017 mongo:6
                    sleep 5
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest -v test_app.py
                '''
            }
        }

    }

    post {

        always {
            sh '''
                docker stop mongo-test || true
                docker rm mongo-test || true
            '''
        }

        success {
            emailext(
                subject: "SUCCESS: Python CI Pipeline",
                body: """
Hello Sam,

Your CI pipeline completed **SUCCESSFULLY**.

Job: ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Status: SUCCESS
URL: ${BUILD_URL}

Regards,
Jenkins
""",
                to: "sadomusica@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "FAILURE: Python CI Pipeline",
                body: """
Hello Sam,

Your CI pipeline has **FAILED**.

Job: ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Status: FAILED
URL: ${BUILD_URL}

Please review the Jenkins logs.
""",
                to: "sadomusica@gmail.com"
            )
        }
    }
}

