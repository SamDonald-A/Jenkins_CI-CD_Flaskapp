pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "samdonalda/sam_flask_app"
        IMAGE_TAG = "${DOCKERHUB_REPO}:latest"

        DOCKERHUB_CREDS = "SAM_DOCKER_HUB"
    }

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
                    export MONGO_URI="mongodb://localhost:27017/test_db"
                    . venv/bin/activate
                    pytest -v test_app.py
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_TAG} .
                '''
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: DOCKERHUB_CREDS,
                    usernameVariable: 'DH_USER',
                    passwordVariable: 'DH_PASS'
                )]) {
                    sh '''
                        echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
                        docker push ${IMAGE_TAG}
                        docker logout
                    '''
                }
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
                subject: "SUCCESS: CI Pipeline (Tests + Docker Push)",
                body: """
Hello Sam,

Your CI pipeline finished SUCCESSFULLY.

✔ Tests Passed  
✔ Docker Image Built  
✔ Docker Image Pushed to DockerHub

Build: ${BUILD_NUMBER}
Job: ${JOB_NAME}
URL: ${BUILD_URL}

Regards,  
Jenkins
""",
                to: "sadomusica@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "FAILED: CI Pipeline (Tests + Docker Push)",
                body: """
Hello Sam,

Your CI pipeline FAILED.

Build: ${BUILD_NUMBER}
Job: ${JOB_NAME}
URL: ${BUILD_URL}

Please check Jenkins logs.

Regards,  
Jenkins
""",
                to: "sadomusica@gmail.com"
            )
        }
    }
}
