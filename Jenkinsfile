pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    
    // environment {
    //     // AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    //     // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    //     GCP_SVC_ACCT = credentials('gcp-creds')
    //     TF_IN_AUTOMATION      = '1'
    // }

    stages {
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                }
                // sh 'terraform init -input=false'
                // sh 'terraform workspace select ${environment}'
                // sh "terraform plan -input=false -out tfplan -var 'version=${params.version}' --var-file=environments/${params.environment}.tfvars"
                // sh 'terraform show -no-color tfplan > tfplan.txt'
                sh ''' /opt/homebrew/bin/terraform --help
                cd modules/${module}
             
                /opt/homebrew/bin/terraform ${action} --auto-approve
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