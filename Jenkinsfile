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
        DEPLOY_SERVER = '37.60.254.21'  // Server IP (Same for both QA and PROD)
        DEPLOY_USERNAME = 'root'
        DEPLOY_PATH = '~/'  // Replace with the path on the server
        DOCKER_CREDENTIALS_ID = 'pralay_doc_cred'  // Corrected variable name
        SSH_CREDENTIALS_ID = 'ssh_key_server_2'  // Replace with the actual Jenkins SSH credentials ID
        BRANCH_NAME = "${GIT_BRANCH.split('/')[1]}"  // Extract branch name
        QA_PORT = '8081'  // Port for QA environment
        PROD_PORT = '9091'  // Port for PROD environment
    }

    stages {

        stage('Check Branch and Deploy') {
            steps {
                script {
                    def DEPLOY_PORT = ''
                    if (BRANCH_NAME == "qa") {
                        // Deploy to QA Server on QA port
                        echo "Deploying to QA environment on port ${QA_PORT}"
                        DEPLOY_PORT = QA_PORT
                    } else if (BRANCH_NAME == "prod") {
                        // Deploy to Production Server on PROD port
                        echo "Deploying to Production environment on port ${PROD_PORT}"
                        DEPLOY_PORT = PROD_PORT
                    } else {
                        echo "Branch is neither 'qa' nor 'prod', skipping deployment."
                        return
                    }

                    sh """
                    sshpass -p 'rakesh123' scp -o StrictHostKeyChecking=no ./docker-compose.yaml ${DEPLOY_USERNAME}@${DEPLOY_SERVER}:${DEPLOY_PATH}
                    sshpass -p 'rakesh123' ssh -o StrictHostKeyChecking=no ${DEPLOY_USERNAME}@${DEPLOY_SERVER} '
                        export DOCKER_ACCOUNT=${DOCKER_ACCOUNT};
                        export DOCKER_IMAGE=${DOCKER_IMAGE};
                        export IMAGE_VERSION=${IMAGE_VERSION};
                        export APP_PORT=${DEPLOY_PORT};  // Pass port as an environment variable
                        docker-compose pull && docker-compose up -d'
                    """
                }
            }
        }
    }
}
