

resource "aws_default_route_table" "vpc-01-default-rt" {
  default_route_table_id = aws_vpc.vpc-01.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-01-igw.id
  }

  tags = {
    Name = "vpc-01-Default/Public-rt"
  }
  
}


resource "aws_route_table" "vpc-01-private-rt" {
  vpc_id = aws_vpc.vpc-01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpc-01-nat-gw.id
  }

  
  tags = {
    Name = "VPC-01-Private-rt"
  }
}

resource "aws_route_table_association" "vpc-01-private-rt-assoc" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.vpc-01-private-subnets[count.index].id
  route_table_id = aws_route_table.vpc-01-private-rt.id
  
}