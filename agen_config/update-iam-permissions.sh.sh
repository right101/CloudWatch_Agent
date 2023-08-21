#!/bin/bash

# Name of the role
ROLE_NAME="jenkins-server-role"

# Define the policy JSON
POLICY_JSON='{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "iam:CreateRole",
              "iam:PutRolePolicy",
              "iam:CreateInstanceProfile",
              "iam:AddRoleToInstanceProfile"
          ],
          "Resource": "*"
      }
  ]
}'

# Create a policy
POLICY_ARN=$(aws iam create-policy --policy-name JenkinsIAMPermissionsPolicy --policy-document "$POLICY_JSON" --query 'Policy.Arn' --output text --region us-west-1)

# Attach policy to the role
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN --region us-west-1
