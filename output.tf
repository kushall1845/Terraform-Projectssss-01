

output "public_alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.public_alb.dns_name
}