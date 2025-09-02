
resource "aws_instance" "vpc_01_web_instance" {
  count         = 3
  ami           = "ami-0cfde0ea8edd312d4" # Replace with your AMI
  instance_type = "t3.micro"
  key_name = "pemkeyohio"

  subnet_id = aws_subnet.vpc-01-public-subnets[count.index % 3].id

  user_data = file("userdata.sh")


  tags = {
    Name = "Web-Server-${count.index+1}"
    Subnet = "Subnet-${count.index % 3}"
  }
}