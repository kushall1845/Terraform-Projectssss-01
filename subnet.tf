
data "aws_availability_zones" "available" {

}

# Public Subnets
resource "aws_subnet" "vpc-01-public-subnets" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = cidrsubnet(var.vpc-01-cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
     Name = "${var.vpc-01-name}-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Type = "Public"
  }
}


resource "aws_subnet" "vpc-01-private-subnets" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = cidrsubnet(var.vpc-01-cidr, 8, count.index + 10)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc-01-name}-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Type = "Private"
  }
}








