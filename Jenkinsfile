node {
	copyArtifacts fingerprintArtifacts: true, optional: true, projectName: 'petclinic', selector: lastSuccessful()
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
			//Run maven image
			sh "docker run --name maven-build-container maven-build"
	   }
	   
	   stage('Deploy') {
			
			sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8080:8080 maven-build-container"
	   }

	   stage('Cleanup - Job Successful') {
	   		sh "docker container prune -f; docker image prune -f"
	   }

	} finally {
		stage('Cleanup - Job Failed') {
			sh "docker container prune -f; docker image prune -f"
			}
	}
}