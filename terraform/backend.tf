terraform {
  backend "s3" {
    bucket = "terraform-backend-raya"
    region = "us-east-1"
    key    = "cloudwatch-agent/terraform.tfstate"
  }
}