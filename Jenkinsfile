#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the repository from your Git repository URL using the 'main' branch
                git branch: 'main', url: 'https://github.com/mvnvedavyas/devopsfinal.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile from the repository
                script {
		    echo "Building Docker image..."
                    def dockerImage = docker.build("devops-app:${env.BUILD_ID}", "-f Dockerfile .")
                    // Save the dockerImage variable as an environment variable for later use
                    echo "Docker image built successfully"
		    env.IMAGE_NAME = "devops-app:${env.BUILD_ID}"
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            environment {
                // Define your Docker Hub username and repository name
                DOCKER_HUB_USERNAME = 'vdvs99'
                DOCKER_HUB_REPOSITORY = 'devops-app'
                // Define your Docker Hub password
                DOCKER_HUB_PASSWORD = 'dckr_pat_IIhwe47UdqsRdKS7GnMiSUjqrQQ'
            }
            steps {
                // Tag the Docker image with Docker Hub repository name
                script {
                    sh "docker tag ${env.IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${env.BUILD_ID}"
                    sh "docker tag ${env.IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"
                }
                // Log in to Docker Hub
                sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"

                // Push the Docker image to Docker Hub
                sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${env.BUILD_ID}"
                sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the Docker container from the built image with port 8000 mapped to the host
                script {
	            try {
                        sh "docker container stop devops_container"
                        sh "docker container rm devops_container"
                    } catch (Exception e) {
                        echo "Container 'devops_container' not found or couldn't be stopped/removed."
                    }
	
                    sh "docker run -p 8000:80 -d --name devops_container ${env.IMAGE_NAME}"
		 
                }
            }
        }
    }
}