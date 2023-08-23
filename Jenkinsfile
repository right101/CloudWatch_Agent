pipeline {
    agent any

    stages {
        
        stage('Install and Start CloudWatch Agent') {
            steps {
                sh '''
                  wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
                  sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

                  sudo cp /var/lib/jenkins/workspace/CloudWatch_Agent-/cw-agent-config.json /opt/aws/amazon-cloudwatch-agent/bin/cw-agent-config.json
                  
                  # Configure the CloudWatch agent (Use your configuration file)
                  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/cw-agent-config.json -s

                  

                '''
                
                
            }
        }
    }
    post {
        // Clean after build
        always {
            cleanWs()
        }
    }
}
