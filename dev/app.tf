#create securit group for the app

resource "aws_security_group" "app" {
  name        = "app"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.bastion.id}"]
  }

  #   ingress {
  #   description      = "SSH from VPC"
  #   from_port        = 8080
  #   to_port          = 8080
  #   protocol         = "tcp"
  #   security_groups  = ["${aws_security_group.alb.id}"]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "${var.envname}-app-sg"
  }
}

#user data to install the webapplications


# data "template_file" "user_data" {
#   template = "${file("app_install.sh")}"
  
# }
 


#create app instance

resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.cherry.id
  subnet_id = aws_subnet.tf_dev_prisubnet[0].id
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  # user_data = data.template_file.user_data.rendered


 tags = {
    Name = "${var.envname}-app"
  }
}






















# resource "aws_instance" "bastion" {
#   ami           = var.ami
#   instance_type = var.type
#   key_name = var.pem
#   vpc_security_group_ids = var.securitygroup


#   tags = {
#     Name = var.envname
#   }
# }