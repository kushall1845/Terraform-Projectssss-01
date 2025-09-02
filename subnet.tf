
data "aws_availability_zones" "available" {

}

# Public Subnets
resource "aws_subnet" "vpc-01-public-subnets" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "vpc-01-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Type = "Public"
  }
}


resource "aws_subnet" "vpc-01-private-subnets" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index + 10)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "vpc-01-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Type = "Private"
  }
}




