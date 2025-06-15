resource "aws_security_group" "focal_sg" {
  name        = "focalboard-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "focalboard_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "focalboard_key" {
  key_name   = "focalboard-key"  # this name will show in AWS
  public_key = tls_private_key.focalboard_key.public_key_openssh
}

resource "aws_instance" "focal_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.focal_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              docker run -d -p 8000:8000 mattermost/focalboard
              EOF

  tags = {
    Name = "focalboard-instance"
  }
}
