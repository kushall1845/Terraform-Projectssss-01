
resource "aws_eip" "vpc-01-nat-eip" {
  

  tags = {
    Name = "${var.vpc-01-name}-NAT-EIP"

    
  }


  depends_on = [aws_internet_gateway.vpc-01-igw]

  
}


resource "aws_nat_gateway" "vpc-01-nat-gw" {
  allocation_id = aws_eip.vpc-01-nat-eip.id
  subnet_id     = aws_subnet.vpc-01-public-subnets[0].id

  tags = {
    Name = "${var.vpc-01-name}-NAT-GW"
  }

  depends_on = [aws_internet_gateway.vpc-01-igw]
}

