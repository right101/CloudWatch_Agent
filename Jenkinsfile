pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                    dir('terraform')
                        sh 'terraform init' 
            }
        }
        stage('Terraform Plan') {
            steps {
                    dir('terraform')
                        sh 'terraform plan' 
                }
            }
        stage('Terraform Apply') {
            steps {
                    dir('terraform')
                        sh 'terraform apply' 
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
