resource "aws_security_group" "sg_vpc" {
  name        = "sg_vpc"
  description = "allow shh"
  vpc_id      = aws_vpc.nikita-vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }
  tags = {
    Name = "sg-vpc"
  }
}

/* resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description      = "allow SSH"
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
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_ec2_aurora" {
  name        = "allow_ec2_aurora"
  description = "Allow EC2 to Aurora traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description      = "allow ec2 to aurora"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_aurora_access" {
  name        = "allow_aurora_access"
  description = "Allow EC2 to aurora"
  vpc_id = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.allow_ssh.id] 
  }

  tags = {
    Name = "aurora-stack-allow-aurora-MySQL"
  }
} */

#create security group for rds db instance
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "permit access from web security group"
  vpc_id      =  aws_vpc.nikita-vpc.id
ingress {
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_groups = [aws_security_group.sg_vpc.id]
}
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
tags = {
  Name = "rds_sg"
}
}