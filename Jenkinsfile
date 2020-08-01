pipeline {
     agent any
     environment {
        CI = "true"
        DOCKER_REPOSITORY = "ifeomau/cloud_devops_capstone_project"
        KUBECONFIG = "/home/ubuntu/.kube/config"
    }
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
          stage('build container') {
            when {
                branch 'master'
            }
            steps {
                 withDockerRegistry([url: "", credentialsId: "docker-hub"]) {
                    sh 'docker version'
                    sh 'docker build -t "$DOCKER_REPOSITORY:$GIT_COMMIT" .'
                    sh 'docker push "$DOCKER_REPOSITORY:$GIT_COMMIT"'
                    sh 'docker tag "$DOCKER_REPOSITORY:$GIT_COMMIT" "$DOCKER_REPOSITORY:latest"'
                    sh 'docker push "$DOCKER_REPOSITORY:latest"'
                }
            }
        }
        stage('deploy') {
            when {
                branch 'master'
            }
            steps {
                withAWS(credentials:'aws-credential'){
                sh 'kubectl version'
                sh 'kubectl apply -f kubernetes-deployment/deployment.yaml'
                }
            }
        }
    }
}