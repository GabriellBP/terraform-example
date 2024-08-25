provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "terraform-example" {
  ami = "ami-0490fddec0cbeb88b"  # https://us-east-2.console.aws.amazon.com/ec2/home?region=us-east-2#AMICatalog:
  instance_type = "t2.nano"  # https://aws.amazon.com/ec2/instance-types/
}