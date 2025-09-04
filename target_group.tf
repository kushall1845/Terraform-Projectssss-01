
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