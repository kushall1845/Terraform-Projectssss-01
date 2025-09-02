
resource "aws_eip" "vpc-01-nat-eip" {
  

  tags = {
    Name = "VPC-01-NAT-EIP"

    
  }


  depends_on = [aws_internet_gateway.vpc-01-igw]

  
}


resource "aws_nat_gateway" "vpc-01-nat-gw" {
  allocation_id = aws_eip.vpc-01-nat-eip.id
  subnet_id     = aws_subnet.vpc-01-public-subnets[0].id

  tags = {
    Name = "VPC-01-NAT-GW"
  }

  depends_on = [aws_internet_gateway.vpc-01-igw]
}

