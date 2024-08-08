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
                    timeout(time: 1, unit: 'MINUTES') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
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
                sh "docker build -t springbootapp ."
            }
        }
        stage("docker push"){
            steps{
                script{
                    echo "pushing the image to dockerhub"
                    withCredentials([usernamePassword(credentialsId: '56f36fe8-8cd3-473b-af3a-6522823b91e8', passwordVariable: 'dockerHubPass', usernameVariable: 'dockerHubUser')]) {
                        sh "docker tag springbootapp ${env.dockerHubUser}/springbootapp:latest"
                        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                        sh "docker push  ${env.dockerHubUser}/springbootapp:latest"
                    }
                }
            }


        }

    }
}

