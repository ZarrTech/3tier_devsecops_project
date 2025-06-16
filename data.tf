data "aws_ami" "amiID" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_secretsmanager_secret_version" "grafana_password" {
  secret_id = "grafana-admin-password"
}


data "aws_availability_zones" "available" {}
