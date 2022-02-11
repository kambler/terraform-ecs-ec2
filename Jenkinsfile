pipeline {
    agent any 
	parameters {
		string(name: "terra_action", defaultValue: "plan", description: "Terraform action to be performed")
		//string(name: "git_codebase", defaultValue: "git@ec2-18-200-215-85.eu-west-1.compute.amazonaws.com:ibm-admin/sastoaws-infra.git", description: "git location of the terraform config files")
		string(name: "main_dir_name", defaultValue: "SAS_to_S3_Project/main", description: "main directory to execute terraform main.tf from")
		string(name: "tf_vars", defaultValue: "", description: "TF vars to be passed in TF command. ex - image_id=ami-abc123")
	}
    stages {
		stage('Terraform code checkout') { 
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rstraining4/tf.git']]])
            }
        }
        stage('Terraform action - init') { 
            steps {
				dir("${params.main_dir_name}"){
					sh "pwd"
					sh "terraform init"
				}
            }
        }
		stage('Terraform action - plan') { 
			when {
				expression {
					params.terra_action == "plan" || params.terra_action == "apply"
				}
			}
            steps {
				dir("${params.main_dir_name}"){
					sh "pwd"
					script {
						if(params.tf_vars == "") {
							sh "terraform plan"				
						}
						else{
							sh 'terraform plan -var="$tf_vars"'				
						}
					}
					
				}
            }
        }
		stage('Terraform action - apply') { 
			when {
				expression {
					params.terra_action == "apply"
				}
			}
            steps {
				dir("${params.main_dir_name}"){
					sh "pwd"
					script {
						if(params.tf_vars == "") {
							sh "terraform apply --auto-approve"				
						}
						else{
							sh 'terraform apply -var="$tf_vars" --auto-approve'				
						}
					}
				}
            }
        }
		stage('Terraform action - destroy') { 
			when {
				expression {
					params.terra_action == "destroy"
				}
			}
            steps {
				dir("${params.main_dir_name}"){
					sh "pwd"
					sh "terraform plan --destroy"
					sh "terraform destroy --auto-approve"
				}
            }
        }
    }
}