pipeline {
    agent {
        label 'my_server_1'  // Replace with your Jenkins agent label
    }
    parameters {
        string(name: 'version', defaultValue: 'v1', description: 'Docker image version')
    }

    environment {
        DOCKER_ACCOUNT = 'pralay1993'
        DOCKER_IMAGE = 'angular8app'
        IMAGE_VERSION = "${params.version}"
        DEPLOY_SERVER = '37.60.254.21' // Replace with the actual server details
        DEPLOY_USERNAME = 'root'
        DEPLOY_PATH = '~/' // Replace with the path on the server
        DOCKER_CREDENTIALS_ID = 'pralay_doc_cred' // Corrected variable name
        SSH_CREDENTIALS_ID = 'ssh_key_server_2' // Replace with the actual Jenkins SSH credentials ID
    }

    stages {
        stage('Push Docker Image') {
            steps {
                script {
                    // Use Docker Hub credentials for pushing the image
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker-compose build'
                        sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
                        sh 'docker-compose push'
                    }
                }
            }
        }

    //     stage('Deploy to Remote Server') {
    //         steps {
    //             script {
    //                 // Use the SSH credentials stored in Jenkins
    //                 sshagent([SSH_CREDENTIALS_ID]) {
    //                     // Secure Copy the docker-compose.yaml to the server
    //                     sh 'scp -o StrictHostKeyChecking=no docker-compose.yaml ${DEPLOY_USERNAME}@${DEPLOY_SERVER}:${DEPLOY_PATH}'

    //                     // SSH into the server and deploy
    //                     sh """
    //                     ssh -o StrictHostKeyChecking=no ${DEPLOY_USERNAME}@${DEPLOY_SERVER} << EOF
    //                     cd ${DEPLOY_PATH}
    //                     docker-compose pull
    //                     docker-compose down
    //                     docker-compose up -d
    //                     EOF
    //                     """
    //                 }
    //             }
    //         }
    //     }
    // }

    // post {
    //     always {
    //         cleanWs() // Clean up the workspace after the pipeline runs
    //     }
    // }
}

