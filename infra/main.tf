provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "http_access" {
  name = "allow_http"
  description = "Allow http and http traffic"

  ingress {
    from_port = 80
    to_port = 80
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

resource "aws_instance" "terraform_example" {
  ami = "ami-0490fddec0cbeb88b"  # https://us-east-2.console.aws.amazon.com/ec2/home?region=us-east-2#AMICatalog:
  instance_type = "t2.nano"  # https://aws.amazon.com/ec2/instance-types/
  vpc_security_group_ids = [ aws_security_group.http_access.id ]
}