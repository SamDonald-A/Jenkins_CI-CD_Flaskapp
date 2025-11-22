pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "samdonalda/sam_flask_app"
        IMAGE_TAG = "${DOCKERHUB_REPO}:latest"

        EC2_USER = "ubuntu"
        EC2_HOST = "18.134.130.136"

        SSH_CREDENTIALS_ID = "SAM_EC2_SHH"
        DOCKERHUB_CREDS = "SAM_DOCKER_HUB"

        MONGO_SECRET_ID = "SAM_MONGO_URI"
        FLASK_SECRET_ID = "SAM_SECRET_KEY"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
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

        stage('Run Pytest in Docker Test Image') {
            steps {
                sh '''
                    docker build -t ${DOCKERHUB_REPO}:test -f Dockerfile .
                    docker run --rm --network host ${DOCKERHUB_REPO}:test pytest -v test_app.py || { echo "Tests Failed"; exit 1; }
                '''
            }
        }

        stage('Build Production Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_TAG} .
                '''
            }
        }

        stage('Push to Docker Hub') {
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

        stage('Deploy to EC2') {
            steps {
                sshagent (credentials: [SSH_CREDENTIALS_ID]) {
                    withCredentials([
                        string(credentialsId: MONGO_SECRET_ID, variable: 'MONGO_URI'),
                        string(credentialsId: FLASK_SECRET_ID, variable: 'SECRET_KEY')
                    ]) {

                        sh """
                            ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} '
                                sudo docker rm -f flask-app || true
                                sudo docker pull ${IMAGE_TAG}
                                sudo docker run -d --name flask-app -p 5000:5000 \
                                    -e MONGO_URI="${MONGO_URI}" \
                                    -e SECRET_KEY="${SECRET_KEY}" \
                                    ${IMAGE_TAG}
                            '
                        """
                    }
                }
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    sleep 5
                    STATUS=$(curl -o /dev/null -s -w "%{http_code}" http://${EC2_HOST}:5000 || echo "000")
                    echo "HTTP STATUS = $STATUS"

                    if [ "$STATUS" -ne 200 ]; then
                        echo "Health check failed (status: $STATUS)"
                        exit 1
                    fi
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
            echo "Pipeline completed successfully.."
            emailext(
                subject: "SUCCESS: Jenkins Pipeline for Flask App",
                body: """
Hello Sam,

Your Jenkins pipeline completed successfully.

Job: ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Status: SUCCESS
Build URL: ${BUILD_URL}

Regards,
Jenkins
""",
                to: "sadomusica@gmail.com"
            )
        }

        failure {
            echo "Pipeline failed.."
            emailext(
                subject: "FAILURE: Jenkins Pipeline for Flask App",
                body: """
Hello Sam,

Your Jenkins pipeline has FAILED.

Job: ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Status: FAILURE
Build URL: ${BUILD_URL}

Please check the Jenkins logs for details.
""",
                to: "sadomusica@gmail.com"
            )
        }
    }
}
