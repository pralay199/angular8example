pipeline {
    agent { label 'my_server_1' }

    environment {
        DOCKER_IMAGE = 'app_8_example:v1' // Replace with your image name
        DEPLOY_SERVER = 'root@37.60.254.21' // Replace with the actual server details
        DEPLOY_PATH = '/root/text/server' // Replace with the path on the server where you want to deploy
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker-compose --build' // Builds the Docker image
                }
            }
        }

        stage('Push Docker Image (Optional)') {
            steps {
                script {
                    sh 'docker tag $DOCKER_IMAGE pralay1993/$DOCKER_IMAGE' // Optional: Tag the image for pushing to DockerHub
                    sh 'docker push pralay1993/$DOCKER_IMAGE' // Optional: Push the image to DockerHub
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    // SCP the Docker Compose file or other deployment scripts if needed
                    sh 'scp -o StrictHostKeyChecking=no docker-compose.yml $DEPLOY_SERVER:$DEPLOY_PATH'

                    // SSH into the remote server and deploy
                    sh """
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER << EOF
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
