pipeline {
    agent any
    
    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        
        stage('Deploy') {
            steps {
                // Tambahkan langkah-langkah untuk melakukan deployment aplikasi ke server atau platform tujuan Anda
            }
        }
    }
}
