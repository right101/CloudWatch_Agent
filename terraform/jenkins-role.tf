resource "aws_iam_policy" "jenkins_permissions" {
  name        = "JenkinsIAMPermissionsPolicy"
  description = "IAM policy for Jenkins"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "iam:CreatePolicy"
          # Add other permissions as necessary
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_to_jenkins" {
  policy_arn = aws_iam_policy.jenkins_permissions.arn
  role       = "jenkins-server-role" # Assuming this role already exists
}
