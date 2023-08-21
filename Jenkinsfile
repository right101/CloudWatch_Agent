pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    sh './terraform/jenkins-role.tf'
                    sh './terraform/cloudagent-role.tf'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh './terraform/jenkins-role.tf'
                    sh './terraform/cloudagent-role.tf'
                    }
                }
            }
        stage('Terraform Apply') {
            steps {
                script {
                    sh './terraform/jenkins-role.tf'
                    sh './terraform/cloudagent-role.tf'
                }
            }
        }

        stage('Install and Start CloudWatch Agent') {
            steps {
                sh '''
                  wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
                  sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
                  
                  # Configure the CloudWatch agent (Use your configuration file)
                  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:./cw-agent-config.json -s
                '''
            }
        }
    }
}
