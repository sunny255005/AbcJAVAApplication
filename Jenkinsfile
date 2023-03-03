pipeline {
    environment { 
        registryCredential = 'docker_nexus'
        GIT_REPO_NAME = GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1') 
        dockerImg = ""
        STAGING_BRANCH = "staging"
        user_env_input = "Development"

    }
    agent any

    stages {
        stage('Which environment to build?') {
            steps {
                script {
                    def userInput = input(id: 'userInput', message: 'Deploy to?',
                    parameters: [[$class: 'ChoiceParameterDefinition', defaultValue: 'Development', 
                        description:'Environment choices', name:'denv', choices: "Development\nTesting"]
                    ])
                    user_env_input = userInput
                    //Use this value to branch to different logic if needed
                }
            }
        }
        stage('Confirm') {
            steps {
                input("Do you want to proceed building in ${user_env_input} environment?")
            }
        }       
        stage('Docker Build') {
            steps {
                echo 'Building..'
                sh 'ls'
                echo GIT_COMMIT
                echo GIT_REPO_NAME
                echo ecr_registry
                script {
                    docker.withRegistry( 'https://115.112.75.210:5006', registryCredential ) {
                        dockerImg =  docker.build("${GIT_REPO_NAME}:${GIT_COMMIT}", "./") 
                    }
                }
            }
        }
        
    }
}
