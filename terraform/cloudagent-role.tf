resource "aws_iam_policy" "cloudwatch_agent_policy" {
  name        = "CloudWatchAgentPolicy"
  description = "Policy for CloudWatch Agent"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "ec2:DescribeTags"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# Create an AWS IAM role
resource "aws_iam_role" "cloudwatch_agent_role" {
  name = "CloudWatchAgentRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ] 
  })
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_agent_policy.arn
  role       = aws_iam_role.cloudwatch_agent_role.name
}

# Create an instance profile
resource "aws_iam_instance_profile" "cloudwatch_agent_instance_profile" {
  name = "CloudWatchAgentInstanceProfile"
  role = aws_iam_role.cloudwatch_agent_role.name
}

resource "aws_instance" "existing_instance" {
  instance_id = "i-026f3f0344f5dbdd8"
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_agent_instance_profile.name

  lifecycle {
    ignore_changes = all
  }
}

