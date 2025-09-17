
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




resource "aws_security_group" "public_alb_sg" {

  description = "This security group is for the public ALB"
  vpc_id      = aws_vpc.vpc-01.id

  tags = {
    Name = "Public-ALB-SG"
  }

  depends_on = [ aws_instance.vpc_01_web_servers ]
}

resource "aws_vpc_security_group_ingress_rule" "inbounc_public_alb" {
  security_group_id = aws_security_group.public_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"  # All protocols
  from_port         = 80
  to_port           = 80

   depends_on = [ aws_security_group.public_alb_sg ]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.public_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  depends_on = [ aws_security_group.public_alb_sg ]
}






resource "aws_security_group" "internal_alb_sg" {
  name        = "internal-alb-sg"
  description = "Allow inbound from trusted sources to internal ALB"
  vpc_id      = aws_vpc.vpc-01.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # or restrict to bastion/NAT
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Internal-ALB-SG"
  }

  depends_on = [ aws_instance.vpc_01_app_servers ]
}