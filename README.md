# CloudWatch_Agent-
This repo will create CloudWatch Agent with Jenkins
This configuration will collect standard system metrics (like CPU, memory, disk, and network usage) and some basic log files (like /var/log/syslog and /var/log/messages).

Configuration Details:

Metrics:

Collects metrics every 60 seconds (metrics_collection_interval).
Metrics include CPU usage, disk usage, disk IO, memory usage, and swap usage.
Dimensions used for CloudWatch include the EC2 Instance ID (${aws:InstanceId}).


Logs:

This configuration collects logs from /var/log/syslog and /var/log/auth.log.
Logs are sent to CloudWatch Logs, with the log group names being syslog and auth.log respectively.
The log stream names will be the instance ID of the EC2 instance.
test

This Jenkins pipeline will:

Update the package repositories.
Install the AWS CLI.
Download and install the CloudWatch Agent.
Use a basic configuration for the CloudWatch Agent.
Start the CloudWatch Agent with the provided configuration.
