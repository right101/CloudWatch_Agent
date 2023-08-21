pipeline {
    agent any

    stages {
        stage('Install AWS CLI') {
            steps {
                script {
                    sh 'chmod +x ./agen_config/aws-cli.sh'
                    sh './agen_config/aws-cli.sh'
                }
            }
        }
        stage('Update IAM Permissions') {
            steps {
                script {
                        sh 'chmod +x ./agen_config/update-iam-permissions.sh'
                        sh './agen_config/update-iam-permissions.sh'
                    }
                }
            }
        stage('Setup AWS Permissions') {
            steps {
                script {
                    sh 'chmod +x ./agen_config/iam-role.sh'
                    sh './agen_config/iam-role.sh'
                }
            }
        }

        stage('Install and Start CloudWatch Agent') {
            steps {
                sh '''
                  wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
                  sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
                  
                  # Configure the CloudWatch agent (Use your configuration file)
                  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:./cloudwatch-config.json -s
                '''
            }
        }
    }
}
