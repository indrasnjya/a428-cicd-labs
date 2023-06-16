pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
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
                sh './script/test.sh'
            }
        }
        
        stage('Manual Approval') {
            steps {
                script {
                    def userInput = input(
                        id: 'approvalInput',
                        message: 'Lanjutkan ke tahap Deploy?',
                        parameters: [
                            booleanParam(defaultValue: false, description: 'Pilih opsi untuk melanjutkan atau menghentikan pipeline', name: 'APPROVAL')
                        ]
                    )
                    if (userInput) {
                        echo 'Melanjutkan ke tahap Deploy'
                    } else {
                        error('Pipeline dihentikan oleh pengguna')
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh './script/deploy.sh'
                script {
                    def deployInput = input(
                        id: 'deployInput',
                        message: 'Aplikasi telah berhasil di-deploy. Apakah Anda ingin menjeda eksekusi selama 1 menit?',
                        parameters: [
                            booleanParam(defaultValue: false, description: 'Pilih opsi untuk menjeda atau melanjutkan eksekusi', name: 'PAUSE')
                        ]
                    )
                    if (deployInput) {
                        echo 'Menjeda eksekusi selama 1 menit...'
                        sleep(time: 1, unit: 'MINUTES')
                    }
                }
            }
        }
    }
}
