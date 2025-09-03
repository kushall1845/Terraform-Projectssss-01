
resource "aws_default_security_group" "vpc-01-default-sg" {
  vpc_id = aws_vpc.vpc-01.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc-01-name}-Default-SG"
  }
}