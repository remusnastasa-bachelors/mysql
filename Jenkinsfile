#!groovy

pipeline {
  environment {
    imageName = "remusnastasa/my-mysql"
    dockerImage = ''
  }
  agent any
  stages {
    stage('Checkout') {
      steps {
      	checkout scm
      }
    }

    stage('Build') {
    	steps {
    		script {
			dockerImage = docker.build imageName
	    	}
	}
    }
    
    stage('Deploy') {
    	steps{
	    	script {
			docker.withRegistry('') {
				dockerImage.push('latest')
			}
	    	}
        }
    }
    
    stage('Rollout') {
    	steps {
        	sh 'kubectl --kubeconfig /etc/kubernetes/kubeconfig --server "https://${KUBE_SERVER}" --token="${SERVICE_ACCOUNT_TOKEN}" rollout restart deployment mysql-deployment'
    	}
    }
    
    stage('Cleanup') {
    	steps {
        	sh "docker rmi $imagename:latest"
    	}
    }
  }
}
