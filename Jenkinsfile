pipeline {
    agent {
        label 'my_server_1'  // Replace with your Jenkins agent label
    }
    parameters {
        string(name: 'version', defaultValue: 'v1', description: 'Docker image version')
    }

    environment {
        DOCKER_IMAGE = 'angular8app' // Replace with your image name
        DOCKER_ACCOUNT = 'pralay1993'
        IMAGE_VERSION = "${params.version}" // Ensure version is passed as a parameter
        DEPLOY_SERVER = '37.60.254.21' // Replace with the actual server details
        DEPLOY_USERNAME = 'root'
        DEPLOY_PATH = '~/' // Replace with the path on the server
        DOCKER_CREDENTIALS_ID = 'pralay1993' // Corrected variable name
    }

    stages {
        stage('Push Docker Image') {
            steps {
                script {
                    // Use Docker Hub credentials for pushing the image
                    withCredentials([usernamePassword(credentialsId: 'pralay1993', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker-compose build'
                        sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
                        sh 'docker-compose push'
                    }
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    // SCP the Docker Compose file or other deployment scripts if needed
                    sh 'ls'
                    sh """scp -o StrictHostKeyChecking=no docker-compose.yaml $DEPLOY_USERNAME@$DEPLOY_SERVER:$DEPLOY_PATH"""

                    // SSH into the remote server and deploy
                    sh """
                    ssh -o StrictHostKeyChecking=no $DEPLOY_USERNAME@$DEPLOY_SERVER << EOF
                    cd $DEPLOY_PATH
                    docker-compose pull # If you're using Docker Compose with images from a registry
                    docker-compose down # Stop the old containers
                    docker-compose up -d # Start the new containers
                    EOF
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean up the workspace after the pipeline runs
        }
    }
}
