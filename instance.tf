
# creation of web servers hsoting nginx in private subnets.

resource "aws_instance" "vpc_01_web_servers" {
  count         = var.instance_count
  ami           = var.ami                       # Replace with your AMI
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.vpc-01-private-subnets[count.index % 3].id
  associate_public_ip_address = false

  user_data = file("userdata.sh")


  tags = {
    Name = "Web-Server-${count.index+1}"
    Subnet = "Subnet-${count.index % 3}"
  }

  depends_on = [ aws_nat_gateway.vpc-01-nat-gw, aws_route_table_association.vpc-01-private-rt-assoc  ]
}


# creation of app servers in private subnets.

resource "aws_instance" "vpc_01_app_servers" {
  count         = var.instance_count
  ami           = var.ami # Replace with your AMI
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.vpc-01-private-subnets-appservers[count.index % 3].id
  associate_public_ip_address = false

  user_data = file("userdata.sh")

  

  

  


  tags = {
    Name = "App-Server-${count.index+1}"
    Subnet = "Private-Subnet-${count.index % 3}"
  }

      depends_on = [ aws_nat_gateway.vpc-01-nat-gw, aws_route_table_association.vpc-01-prvtapp-servers-rt-assoc  ]
  
}






# creation of jump server in public subnets.

resource "aws_instance" "vpc_01_Jump_Servers" {
  count         = var.instance_count
  ami           = var.ami # Replace with your AMI
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.vpc-01-public-subnets[count.index % 3].id
  associate_public_ip_address = true

  user_data = file("tomcat.sh")

  

  


  tags = {
    Name = "Jump-Server-${count.index+1}"
    Subnet = "Public-Subnet-${count.index % 3}"
  }

     depends_on = [ aws_internet_gateway.vpc-01-igw ]
  
}






