
resource "aws_internet_gateway" "vpc-01-igw" {
    vpc_id = aws_vpc.vpc-01.id

    tags = {
        Name = "VPC-01-IGW"
    }
  
}