

resource "aws_default_route_table" "vpc-01-default-rt" {
  default_route_table_id = aws_vpc.vpc-01.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-01-igw.id
  }

  tags = {
    Name = "${var.vpc-01-name}-Default/Public-rt"
  }
  
}


resource "aws_route_table" "vpc-01-private-rt" {
  vpc_id = aws_vpc.vpc-01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpc-01-nat-gw.id
  }

  
  tags = {
    Name = "${var.vpc-01-name}-Private-rt"
  }

  depends_on = [ aws_nat_gateway.vpc-01-nat-gw ]
}

resource "aws_route_table_association" "vpc-01-private-rt-assoc" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.vpc-01-private-subnets[count.index].id
  route_table_id = aws_route_table.vpc-01-private-rt.id

  depends_on = [ aws_route_table.vpc-01-private-rt ]
  
}


resource "aws_route_table_association" "vpc-01-prvtapp-servers-rt-assoc" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.vpc-01-private-subnets-appservers[count.index].id
  route_table_id = aws_route_table.vpc-01-private-rt.id

  depends_on = [ aws_route_table.vpc-01-private-rt ]
  
}


resource "aws_route_table_association" "vpc-01-private-dbs-rt-assoc" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.vpc-01-private-subnets-dbs[count.index].id
  route_table_id = aws_route_table.vpc-01-private-rt.id

  depends_on = [ aws_route_table.vpc-01-private-rt ]
  
}