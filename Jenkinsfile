node {
	try {
	   stage('Clone My Repository') {
			// Cloned my GitHub repository
			git 'https://github.com/animeshdas/spring-petclinic.git'
		
	   }
	   stage('Build The Maven Image') {
			docker.build("maven-build")
	   }
	   
	   stage('Cleanup Earlier Docker Build Containers') {
			//sh "docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi"
			sh "docker container prune -f ; docker images prune -f"
	   }
	   
	   stage('Run Maven Build Container') {
			//Run maven image
			sh "docker run --rm --name maven-build-container maven-build"
	   }
	   
	   stage('Deploy the Petclinic Application') {
			
			 //Remove maven-build-container if it exisits
			sh " docker rm -f java-deploy-container"
		   
			sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8080:8080 animeshdas/petclinic-deploy"
	   }
	} finally {
		stage('Final Cleanup Any Dangling Containers') {
			sh "docker container prune -f ; docker images prune -f"
	}
}