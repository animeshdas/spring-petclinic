node {
	try {

		stage('Initialize') {
			//sh "docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi"
			sh " docker container prune -f ; docker image prune -f"
			//def mavenHome  = tool 'myMaven'
    		//env.PATH = "${mavenHome}/bin:${env.PATH}"
	   }

	   stage('Clone') {
			// Cloned my GitHub repository
			git 'https://github.com/animeshdas/spring-petclinic.git'
		
	   }

 	   stage('Build') {
			docker.build("maven-build")
	   }
	   
   	   stage('Test') {
   	   		copyArtifacts fingerprintArtifacts: true, optional: true, projectName: 'petclinic', selector: lastSuccessful()
			//Run maven image
			sh "docker run --name maven-build-container maven-build"
	   }
	   
	   stage('Deploy') {
			//copyArtifacts fingerprintArtifacts: true, optional: true, projectName: 'petclinic', selector: lastSuccessful()
			sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8090:8090 maven-build:latest"
	   }

	   stage('Post-Cleanup') {
	   		sh "docker container prune -f; docker image prune -f"
	   }

	} finally {
		//stage('Post-Cleanup - on Failures') {
			sh "docker container prune -f; docker image prune -f"
		//	}
	}
}