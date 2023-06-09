pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '-p 3000:3000'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        
        stage('Manual Approval') {
            steps {
                script {
                    def userInput = input(
                id: 'approvalInput',
                message: 'Lanjutkan ke tahap Deploy?',
                parameters: [
                    [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Pilih opsi untuk melanjutkan atau menghentikan pipeline', name: 'APPROVAL']
                ]
            )
            if (userInput == true) {
                echo 'Melanjutkan ke tahap Deploy'
            } else {
                error('Pipeline dihentikan oleh pengguna')
                    }
                }
            }
        }
        
        stage('Deploy') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
