pipeline{
    agent any
    environment {
        BRANCHE_DEV = 'origin/main'
        DOCKER_IMAGE_NAME = "devops-ci-cd"
    }
    stages{
        stage("git checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/firashkimi/spring-jenkins-ci-cd.git']])
                echo 'Pulling... ' + env.GIT_BRANCH
            }
        }
        stage('Tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage("sonarscan"){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-jenkins') {

                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }
        stage('Maven Build and Package') {
            steps {
                script {
                    sh 'mvn clean package -DskipTests'
                }
            }
            post {
                success {
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage("docker build"){
            steps{
                sh "docker build -t firas709/springbootapp ."
            }
        }
        stage("docker push"){
            steps{
                script{
                    echo "pushing the image to dockerhub"
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        sh "docker login -u firas709 -p ${dockerhubpwd}"
                        sh "docker push  firas709/springbootapp:latest"
                    }
                }
            }


        }

    }
}

