pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                bat 'npm install'
            }
        }

        stage('Test') {
            steps {
                bat '.\\jenkins\\scripts\\test.bat'
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
                bat '.\\jenkins\\scripts\\deploy.bat'
                script {
                    input(
                        id: 'deployInput',
                        message: 'Aplikasi telah berhasil di-deploy. Apakah Anda ingin menjeda eksekusi selama 1 menit?',
                        parameters: [
                            [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Pilih opsi untuk menjeda atau melanjutkan eksekusi', name: 'PAUSE']
                        ]
                    )
                    if (params.PAUSE == true) {
                        echo 'Menjeda eksekusi selama 1 menit...'
                        sleep(time: 1, unit: 'MINUTES')
                    }
                }
            }
        }
    }
}
