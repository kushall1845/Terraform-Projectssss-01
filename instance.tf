
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

  provisioner "remote-exec" {
    inline = [
      # Update packages
      "sudo apt update -y",
      "sudo apt upgrade -y",

      # Install Java
      "sudo apt install -y openjdk-11-jdk",

      # Install Tomcat
      "wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz",
      "tar xzvf apache-tomcat-9.0.73.tar.gz",
      "sudo mv apache-tomcat-9.0.73 /opt/tomcat",

      # Make scripts executable
      "chmod +x /opt/tomcat/bin/*.sh",

      # Create systemd service for Tomcat
      "sudo bash -c 'cat > /etc/systemd/system/tomcat.service <<EOF\n[Unit]\nDescription=Apache Tomcat Web Application Container\nAfter=network.target\n\n[Service]\nType=forking\nEnvironment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64\nExecStart=/opt/tomcat/bin/startup.sh\nExecStop=/opt/tomcat/bin/shutdown.sh\nUser=ubuntu\nGroup=ubuntu\nRestart=always\n\n[Install]\nWantedBy=multi-user.target\nEOF'",

      # Reload systemd and start Tomcat
      "sudo systemctl daemon-reexec",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable tomcat",
      "sudo systemctl start tomcat",

      # Confirm it's running
      "sudo systemctl status tomcat --no-pager"
    ]
  }

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("key.pem")
      host        = self.private_ip
      bastion_host        = aws_instance.vpc_01_Jump_Servers[count.index % var.instance_count].public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file("key.pem")

    }


  

  

  


  tags = {
    Name = "App-Server-${count.index+1}"
    Subnet = "Private-Subnet-${count.index % 3}"
  }

      depends_on = [ aws_nat_gateway.vpc-01-nat-gw, aws_route_table_association.vpc-01-prvtapp-servers-rt-assoc , aws_instance.vpc_01_Jump_Servers , aws_instance.vpc_01_web_servers  ]
  
}






# creation of jump server in public subnets.

resource "aws_instance" "vpc_01_Jump_Servers" {
  count         = var.instance_count
  ami           = var.ami # Replace with your AMI
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.vpc-01-public-subnets[count.index % 3].id
  associate_public_ip_address = true

    
  provisioner "file" {
    source      = "${path.module}/key.pem"
    destination = "/home/ubuntu/pemkeyohio"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ubuntu/pemkeyohio",
      "chown ubuntu:ubuntu /home/ubuntu/pemkeyohio"
    ]
  }


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key.pem")
    host        = self.public_ip
  }



  

  


  tags = {
    Name = "Jump-Server-${count.index+1}"
    Subnet = "Public-Subnet-${count.index % 3}"
  }

     depends_on = [ aws_internet_gateway.vpc-01-igw ]
  
}






