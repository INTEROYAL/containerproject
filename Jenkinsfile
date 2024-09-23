pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-2'  // Example: us-east-1
        AWS_ACCOUNT_ID = '854169191699'
        ECR_REPO = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/portfolio"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pull code from the GitHub repository
                git branch: 'main', url: 'https://github.com/your-github-username/your-repo-name.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t portfolio:latest .'
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    // Login to ECR using AWS CLI
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Tag and push the Docker image to ECR
                    sh '''
                    docker tag portfolio:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    // Apply Kubernetes manifests for deployment and service
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
