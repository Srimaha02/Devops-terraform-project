data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "ec2_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet_1.id

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  key_name = "devops-key"

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Terraform-EC2-1"
  }
}


resource "aws_instance" "ec2_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet_2.id

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  key_name = "devops-key"

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Terraform-EC2-2"
  }
}