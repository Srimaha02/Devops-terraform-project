output "vpc_id" {
  value = aws_vpc.demovpc.id
}

output "subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "ec2_1_public_ip" {
  value = aws_instance.ec2_1.public_ip
}

output "ec2_2_public_ip" {
  value = aws_instance.ec2_2.public_ip
}