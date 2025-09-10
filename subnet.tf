
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



resource "aws_subnet" "vpc-01-private-subnets-appservers" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = cidrsubnet(var.vpc-01-cidr, 8, count.index + 20)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc-01-name}-private-subnet-appserver-${data.aws_availability_zones.available.names[count.index]}"
    Type = "Private-APP-SERVER"
  }
}



resource "aws_subnet" "vpc-01-private-subnets-dbs" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.vpc-01.id
  cidr_block              = cidrsubnet(var.vpc-01-cidr, 8, count.index + 30)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc-01-name}-private-subnet-appserver-${data.aws_availability_zones.available.names[count.index]}"
    Type = "DB_Subnets"
  }
}












