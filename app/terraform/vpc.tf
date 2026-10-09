resource "aws_vpc" "demovpc" {
  cidr_block = "11.0.0.0/16"

  tags = {
    Name = "MyTerraformVPC"
  }
}