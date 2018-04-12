node {
	try {
	   stage('Clone My Repository') {
			// Cloned my GitHub repository
			git 'https://github.com/animeshdas/spring-petclinic.git'
		
	   }

	   	stage('Startup Cleaner') {
			//sh "docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi"
			sh " docker container prune -f ; docker image prune -f"
	   }
	   
	   stage('Build The Maven Image') {
			docker.build("maven-build")
	   }
	   
   	   stage('Run Maven Build Container') {
			//Run maven image
			sh " docker run --rm --name maven-build-container maven-build"
	   }
	   
	   stage('Deploy the Petclinic Application') {
			
			sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8080:8080 animeshdas/petclinic-deploy"
	   }

	   stage('Final Cleanup - After SUCCESS') {
	   		sh " docker container prune -f; docker image prune -f"
	   }

	} finally {
		stage('Final Cleanup - After FAILURES') {
			sh " docker container prune -f; docker image prune -f"
			}
	}
}