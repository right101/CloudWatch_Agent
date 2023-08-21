#!/bin/bash

# Define the role name and policy name
ROLE_NAME="EC2CloudWatchRole"
POLICY_NAME="CloudWatchEC2Policy"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Create the IAM role with trust policy for EC2
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'

# Create policy for CloudWatch
aws iam put-role-policy --role-name $ROLE_NAME --policy-name $POLICY_NAME --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "cloudwatch:PutMetricData",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:AttachRolePolicy",
                "iam:DetachRolePolicy",
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:CreateInstanceProfile",
                "iam:AddRoleToInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile",
                "ec2:AssociateIamInstanceProfile"
            ],
            "Resource": "*"
        }
    ]
}'

# Create an instance profile and add the role to the profile
aws iam create-instance-profile --instance-profile-name $ROLE_NAME
aws iam add-role-to-instance-profile --instance-profile-name $ROLE_NAME --role-name $ROLE_NAME

# Pause for a few seconds; sometimes there's a slight delay before the instance profile is ready
sleep 10

# Attach the IAM role to the Jenkins EC2 instance
aws ec2 associate-iam-instance-profile --instance-id $INSTANCE_ID --iam-instance-profile Name=$ROLE_NAME
