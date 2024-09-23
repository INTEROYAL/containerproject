pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t your-username/portfolio:latest .'
                }
            }
        }
        stage('Login to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com'
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh 'docker tag your-username/portfolio:latest your-account-id.dkr.ecr.your-region.amazonaws.com/portfolio:latest'
                    sh 'docker push your-account-id.dkr.ecr.your-region.amazonaws.com/portfolio:latest'
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
