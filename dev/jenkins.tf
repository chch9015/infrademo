#create securit group for the tomcat

resource "aws_security_group" "jenkins" {
  name        = "jenkins"
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
    Name = "${var.envname}-jenkins-sg"
  }
}

#user data to install the webapplications


data "template_file" "user_data1" {
  template = "${file("jenkins_install.sh")}"

}
 


#create jenkins instance

resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.cherry.id
  subnet_id = aws_subnet.tf_dev_prisubnet[0].id
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  user_data = data.template_file.user_data1.rendered


 tags = {
    Name = "${var.envname}-jenkins"
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