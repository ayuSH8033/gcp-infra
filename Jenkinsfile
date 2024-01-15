pipeline {
    agent any
    environment {
    CLOUDSDK_CORE_PROJECT='infra-testing-2023'
    CLIENT_EMAIL='infra-manager-testing-sa@infra-testing-2023.iam.gserviceaccount.com'
    GCLOUD_CREDS=credentials('gcp-creds')
  }

    parameters {
        choice(
            choices: ['plan', 'apply'],
            description: 'Terraform action to be performed',
            name: 'action')
    }
    stages {
        stage('GCP-Checkout'){
    steps{
        sh '''
            curl -O  https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-459.0.0-darwin-x86_64.tar.gz
            tar -xzvf ./google-cloud-cli-459.0.0-darwin-x86_64.tar.gz 
            ls
            ./google-cloud-sdk/install.sh
            ./google-cloud-sdk/bin/gcloud init
            ./google-cloud-sdk/bin/gcloud version
            ./google-cloud-sdk/bin/gcloud config set project infra-testing-2023;
            ./google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ${GCLOUD_CREDS}
            ./google-cloud-sdk/bin/gcloud compute zones list
            ./google-cloud-sdk/bin/gcloud config list
        '''
        }   

}
        stage('Plan') {
            when {
                expression { params.action == 'plan' }
            }
            steps {
                sh '''
                 ls
                 /opt/homebrew/bin/tofu --help
                 cd modules/${module}
                 /opt/homebrew/bin/tofu init
                 /opt/homebrew/bin/tofu plan -var-file=../../variables/dev/${module}/terraform.tfvars
                '''
            }
        }

    stage('apply') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                sh '''
                 ./google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ${GCLOUD_CREDS}
                ls
                 cd modules/${module}
                 /opt/homebrew/bin/tofu init
                 /opt/homebrew/bin/tofu plan -var-file=../../variables/dev/${module}/terraform.tfvars
                 /opt/homebrew/bin/tofu apply -var-file=../../variables/dev/${module}/terraform.tfvars --auto-approve
                 '''
            }
        }
}
}