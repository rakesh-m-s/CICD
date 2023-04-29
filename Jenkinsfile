pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                git 'https://github.com/rakesh-m-s/CICD.git'
            }
        }
        stage('build'){
            steps {
         withMaven(maven: 'mvn') {
            sh "mvn clean package"
            }
         }
        }
        stage('SonarQube') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Quality Gates') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Docker Build and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'project', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'chmod 777 docker.sh'
                    sh './docker.sh'
                }
                }
            }
        stage('Kubernetes Deployment') {
            steps {
               sh 'kubectl apply -f deployment.yml'
                }
            }
    }
}
