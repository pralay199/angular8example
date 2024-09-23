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
        BRANCH_NAME = "${GIT_BRANCH.split("/")[1]}"
    }

    stages {
        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //             // Use Docker Hub credentials for pushing the image
        //             withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
        //                 sh 'docker build -t ${DOCKER_ACCOUNT}/${DOCKER_IMAGE}:${IMAGE_VERSION} .'
        //                 sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
        //                 sh 'docker push ${DOCKER_ACCOUNT}/${DOCKER_IMAGE}:${IMAGE_VERSION}'
        //             }
        //         }
        //     }
        // }
        // stage('Connect to Remote Server') {
        //     steps {
        //         script {
        //             sh """sshpass -p rakesh123 scp -o StrictHostKeyChecking=no ./docker-compose.yaml ${DEPLOY_USERNAME}@${DEPLOY_SERVER}:./"""
        //                 sh """ sshpass -p rakesh123 ssh -o StrictHostKeyChecking=no  ${DEPLOY_USERNAME}@${DEPLOY_SERVER} '
        //                   export DOCKER_ACCOUNT=${DOCKER_ACCOUNT};
        //             export DOCKER_IMAGE=${DOCKER_IMAGE};
        //             export IMAGE_VERSION=${IMAGE_VERSION};
        //             docker-compose pull && docker-compose up -d'
        //             """
        //             }
        //         }
        // }
        stage('check branch') {
            steps {
                script {
                    sh """echo ${BRANCH_NAME}"""
                    }
                }
        }
    }

    // post {
    //     always {
    //         cleanWs() // Clean up the workspace after the pipeline runs
    //     }
    // }
    
}
