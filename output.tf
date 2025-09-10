

output "public_alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.public_alb.dns_name
}

output "jump_server_ips" {
  description = "Public IP addresses of the Jump Servers"
  value       = [for instance in aws_instance.vpc_01_Jump_Servers : instance.public_ip]
  
}


output "web_server_ips" {
  description = "Private IP addresses of the Web Servers"
  value       = [for instance in aws_instance.vpc_01_web_servers : instance.private_ip]
  

}


output "app_server_ips" {
  description = "Private IP addresses of the App Servers"
  value       = [for instance in aws_instance.vpc_01_app_servers : instance.private_ip]
  
}


output "mydb_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.mydb.endpoint
  
}


