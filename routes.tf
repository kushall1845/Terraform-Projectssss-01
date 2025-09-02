

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