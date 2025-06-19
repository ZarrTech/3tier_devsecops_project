resource "aws_security_group" "eks_ingress" {
  name        = "eks-ingress-sg"
  description = "Allow ingress from remote server"
  vpc_id      = module.vpc.vpc_id # Use data or resource reference

  ingress {
    description      = "Allow HTTP from remote server"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.remote_server_ip]
  }

  ingress {
    description      = "Allow HTTPS from remote server"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.remote_server_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-ingress-access"
  }
}
