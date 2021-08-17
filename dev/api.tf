#create securit group for the api

resource "aws_security_group" "api" {
  name        = "api"
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
    Name = "${var.envname}-api-sg"
  }
}

#user data to install the webapilications


# data "template_file" "user_data" {
#   template = "${file("api_install.sh")}"
  
# }
 


#create api instance

resource "aws_instance" "api" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.cherry.id
  subnet_id = aws_subnet.tf_dev_prisubnet[0].id
  vpc_security_group_ids = ["${aws_security_group.api.id}"]
  # user_data = data.template_file.user_data.rendered


 tags = {
    Name = "${var.envname}-api"
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