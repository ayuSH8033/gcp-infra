pipeline {
    agent any
    environment {
    CLOUDSDK_CORE_PROJECT='infra-testing-2023'
    CLIENT_EMAIL='ayush.chotu51@gmail.com'
    GCLOUD_CREDS=credentials('gcp-creds')
  }

    // parameters {
    //     string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
    //     string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
    //     booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    // }
    
    // environment {
    //     // AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    //     // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    //     GCP_SVC_ACCT = credentials('gcp-creds')
    //     TF_IN_AUTOMATION      = '1'
    // }

    stages {
        stage('GCP-Checkout'){
    steps{

        //Deploy to GCP
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
            steps {
                // script {
                //     currentBuild.displayName = params.version
                // }
                // sh 'terraform init -input=false'
                // sh 'terraform workspace select ${environment}'
                // sh "terraform plan -input=false -out tfplan -var 'version=${params.version}' --var-file=environments/${params.environment}.tfvars"
                // sh 'terraform show -no-color tfplan > tfplan.txt'
                sh '''
                 ls
                //  gcloud version
                //  gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                //  gcloud compute zones list
                 /opt/homebrew/bin/tofu --help
                 cd modules/${module}
                 /opt/homebrew/bin/tofu init
                 /opt/homebrew/bin/tofu plan -var-file=../../variables/dev/${module}/terraform.tfvars
                '''
                        // cd terragrunt/${module}
                // ls
                // pwd
                // /opt/homebrew/bin/terragrunt --help
                // /opt/homebrew/bin/tofu init
                // terragrunt ${action} --auto-approve
            }
        }

    //     stage('Approval') {
    //         when {
    //             not {
    //                 equals expected: true, actual: params.autoApprove
    //             }
    //         }

    //         steps {
    //             script {
    //                 def plan = readFile 'tfplan.txt'
    //                 input message: "Do you want to apply the plan?",
    //                     parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
    //             }
    //         }
    //     }

    //     stage('checking') {
    //         steps {
    //             sh "/opt/homebrew/bin/terraform validate "
    //         }
    //     }
    // }

    // post {
    //     always {
    //         archiveArtifacts artifacts: 'tfplan.txt'
    //     }
    // }
}
}