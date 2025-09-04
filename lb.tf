
resource "aws_lb" "public_alb" {
  
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb_sg.id]
  subnets            = [for subnet in aws_subnet.vpc-01-public-subnets : subnet.id]

  tags = {
    Name = "Public-ALB"
  }

  depends_on = [ aws_lb_target_group_attachment.web_servers_attachment ]
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }

    depends_on = [ aws_lb.public_alb ]

  
}





