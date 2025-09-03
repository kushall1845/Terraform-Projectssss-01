
resource "aws_vpc" "vpc-01" {
    cidr_block = var.vpc-01-cidr
    
    tags = {
        Name = var.vpc-01-name
    }
  
}









