provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "terraform_security_group" {
  name = "terraform_security_group"
  description = "Allow http, http traffic and SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "terraform-keypair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "terraform_example" {
  ami = "ami-0490fddec0cbeb88b"  # https://us-east-2.console.aws.amazon.com/ec2/home?region=us-east-2#AMICatalog:
  instance_type = "t2.nano"  # https://aws.amazon.com/ec2/instance-types/
  user_data = file("start_docker.sh")
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.terraform_security_group.id]
}