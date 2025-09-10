
resource "aws_lb_target_group" "web_tg" {
  
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc-01.id
  target_type = "instance"

  tags = {
    Name = "Web-TG"
  }

    depends_on = [ aws_instance.vpc_01_web_servers ]
}


resource "aws_lb_target_group_attachment" "web_servers_attachment" {

  count              = length(aws_instance.vpc_01_web_servers)
  target_group_arn   = aws_lb_target_group.web_tg.arn
  target_id          = aws_instance.vpc_01_web_servers[count.index].id
  port               = 80


 
    depends_on = [ aws_lb_target_group.web_tg ]


    
}




resource "aws_lb_target_group" "app_tg" {
  
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-01.id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "App-TG"
  }

    depends_on = [ aws_instance.vpc_01_app_servers ]
}

resource "aws_lb_target_group_attachment" "app_servers_attachment" {
  count            = length(aws_instance.vpc_01_app_servers)
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.vpc_01_app_servers[count.index].id  
  port             = 80

  depends_on = [ aws_lb_target_group.app_tg ]
}



