#create securit group for the alb

resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "${var.envname}-alb-sg"
  }
}

#=======================================
#creating the jenkins load balancer
#create target group
#=======================================
resource "aws_lb_target_group" "alb-jenkins-tg" {
  name     = "dev-jenkins-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev.id

 tags = {
    Name = "${var.envname}-jenkins-tg"
  }  

}

#target group attach to instance
resource "aws_lb_target_group_attachment" "attach-tg-jenkins" {
  target_group_arn = aws_lb_target_group.alb-jenkins-tg.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}

#alb listerner to accept enduser ips
resource "aws_lb_listener" "jenkins-listener" {
  load_balancer_arn = aws_lb.alb-jenkins.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-jenkins-tg.arn
  }
  }


#create alb
resource "aws_lb" "alb-jenkins" {
  name               = "dev-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.tf_dev_pubsubnet.*.id
  enable_deletion_protection = false



 tags = {
    Name = "${var.envname}-jenkins-alb"
  }
}

#=====================================
#creating the app load balancer
#create target group
#=====================================
resource "aws_lb_target_group" "alb-app-tg" {
  name     = "dev-app-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev.id

 tags = {
    Name = "${var.envname}-app-tg"
  }  

}

#target group attach to instance
resource "aws_lb_target_group_attachment" "attach-tg-app" {
  target_group_arn = aws_lb_target_group.alb-app-tg.arn
  target_id        = aws_instance.app.id
  port             = 8080
}

#alb listerner to accept enduser ips
resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.alb-app.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-app-tg.arn
  }
  }


#create alb
resource "aws_lb" "alb-app" {
  name               = "dev-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.tf_dev_pubsubnet.*.id
  enable_deletion_protection = false



 tags = {
    Name = "${var.envname}-app-alb"
  }
}


#=====================================
#creating the api load balancer
#create target group
#=====================================
resource "aws_lb_target_group" "alb-api-tg" {
  name     = "dev-api-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev.id

 tags = {
    Name = "${var.envname}-api-tg"
  }  

}

#target group attach to instance
resource "aws_lb_target_group_attachment" "attach-tg-api" {
  target_group_arn = aws_lb_target_group.alb-api-tg.arn
  target_id        = aws_instance.api.id
  port             = 8080
}

#alb listerner to accept enduser ips
resource "aws_lb_listener" "api-listener" {
  load_balancer_arn = aws_lb.alb-api.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-api-tg.arn
  }
  }


#create alb
resource "aws_lb" "alb-api" {
  name               = "dev-api-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.tf_dev_prisubnet.*.id
  enable_deletion_protection = false



 tags = {
    Name = "${var.envname}-api-alb"
  }
}














