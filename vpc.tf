
resource "aws_vpc" "vpc-01" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "VPC-01"
    }
  
}