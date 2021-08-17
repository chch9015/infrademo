#create securit group for the bastion

resource "aws_security_group" "bastion" {
  name        = "dev-bastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
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
    Name = "${var.envname}-bastion-sg"
  }
}


#creating a key pair
resource "aws_key_pair" "cherry" {
  key_name   = "cherry-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+VgeNTBJDTP/7bQJ5/w0pHxnMEzDPmJGTfujbrn8Z1hcKIxIM76N38l0YwgzBb1oBJKLtfiyiiEuYypKqArP/OpDFku+W72vP5gNgrQOCFsjOgIWTHduTsaQoCi9rqWvnryqvRQHqNRBLYgnulqEavA1pRfFC74oROh+h9DhhH4Zz0vX+Swp3IR4I4teD6vvJsT5rrO3wkwnR7OprTR6v29M4up5TNViN9hnCT7WSbubFqm5PS1UehnK2IQCDbYt/IV1KoMUjY0qiZ/u6F127lO1CRdwb28MDROrp4jV/SBsP82PWVTMxjI5QMPV6xcTJduLbjI223U0kXazzSTcvhA7NQZ9ZbsZdmowCnwa4Cph2n5HDhq+Jh9jjFBvzl88+xLP0BamHNzHPUXTRjQJIjHYoDs+qMssRt97sdYrFkY+5q30y6x7qyT/p3vN0De7v5BHy6J8BPuHG8zhfFJIKM5zZv21aPBY0hE96B4LEj4H1Z7W9Xz3FcX7zleQQuQ0= hp@hp-PC"
  }

#creating aws ec2 instance

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.cherry.id
  subnet_id = aws_subnet.tf_dev_pubsubnet[0].id
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]


 tags = {
    Name = "${var.envname}-bastion"
  }
}




