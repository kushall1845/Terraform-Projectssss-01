


# creation of RDS subnet group


resource "aws_db_subnet_group" "vpc-01-rds-subnet-group" {
 
  subnet_ids = [for subnet in aws_subnet.vpc-01-private-subnets-dbs : subnet.id]
  tags = {
    Name = "${var.vpc-01-name}-RDS-Subnet-Group"
  }

  depends_on = [ aws_lb_listener.http_listener ]

}


# creation of RDS instance 

resource "aws_db_instance" "mydb" {
  identifier         = var.mydb_identifier
  engine             = var.mydb_engine
  instance_class     = var.mydb_instance_class
  allocated_storage  = var.mydb_allocated_storage
  username           = var.mydb_username
  password           = var.mydb_password
  db_subnet_group_name = aws_db_subnet_group.vpc-01-rds-subnet-group.name
  vpc_security_group_ids = [aws_vpc.vpc-01.default_security_group_id]
  skip_final_snapshot = true


  tags = {
    Name = var.mydb_identifier
  }

  depends_on = [ aws_db_subnet_group.vpc-01-rds-subnet-group ]
}







 