#create securit group for the rds

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.bastion.id}"]
  }
    ingress {
    description      = "SSH from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.app.id}"]
  }
    ingress {
    description      = "SSH from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.jenkins.id}"]
  }
      ingress {
    description      = "SSH from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.api.id}"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "${var.envname}-rds-sg"
  }
}


#create subnet group
resource "aws_db_subnet_group" "sub_group" {
  name       = "rds-subnet-group"
  subnet_ids = "${aws_subnet.tf_dev_pubsubnet.*.id}"

 tags = {
    Name = "${var.envname}-rds-subnet_group"
  }
}

#create rds
resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "dev_api"
  username             = "dev_apiuser"
  password             = "IjRJnKj2hFknimX7vkUc"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.sub_group.name}"
  multi_az             = true

 tags = {
    Name = "${var.envname}-rds"
  }

}


