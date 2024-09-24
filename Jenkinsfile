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
        DEPLOY_QA_SERVER = '37.60.254.21'  // QA server IP
        DEPLOY_PROD_SERVER = '37.60.250.194'  // PROD server IP
        DEPLOY_USERNAME = 'root'
        DEPLOY_PATH = '~/'  // Replace with the path on the server
        DOCKER_CREDENTIALS_ID = 'pralay_doc_cred'  // Corrected variable name
        SSH_CREDENTIALS_ID = 'ssh_key_server_2'  // Replace with the actual Jenkins SSH credentials ID
        BRANCH_NAME = "${GIT_BRANCH.split('/')[1]}"  // Extract branch name
    }

    stages {

        stage('Check Branch and Deploy') {
            steps {
                script {
                    if (BRANCH_NAME == "qa") {
                        // Deploy to QA Server
                        echo "Deploying to QA environment"
                        sh """
                        sshpass -p 'rakesh123' scp -o StrictHostKeyChecking=no ./docker-compose.yaml ${DEPLOY_USERNAME}@${DEPLOY_QA_SERVER}:${DEPLOY_PATH}
                        sshpass -p 'rakesh123' ssh -o StrictHostKeyChecking=no ${DEPLOY_USERNAME}@${DEPLOY_QA_SERVER} '
                            export DOCKER_ACCOUNT=${DOCKER_ACCOUNT};
                            export DOCKER_IMAGE=${DOCKER_IMAGE};
                            export IMAGE_VERSION=${IMAGE_VERSION};
                            docker-compose pull && docker-compose up -d'
                        """
                    } else if (BRANCH_NAME == "prod") {
                        // Deploy to PROD Server
                        echo "Deploying to Production environment"
                        sh """
                        sshpass -p 'rakesh123' scp -o StrictHostKeyChecking=no ./docker-compose.yaml ${DEPLOY_USERNAME}@${DEPLOY_PROD_SERVER}:${DEPLOY_PATH}
                        sshpass -p 'rakesh123' ssh -o StrictHostKeyChecking=no ${DEPLOY_USERNAME}@${DEPLOY_PROD_SERVER} '
                            export DOCKER_ACCOUNT=${DOCKER_ACCOUNT};
                            export DOCKER_IMAGE=${DOCKER_IMAGE};
                            export IMAGE_VERSION=${IMAGE_VERSION};
                            docker-compose pull && docker-compose up -d'
                        """
                    } else {
                        echo "Branch is neither 'qa' nor 'prod', skipping deployment."
                    }
                }
            }
        }
    }
}
