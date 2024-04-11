#create DB subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]
  tags = {
    Name = "rds_subnet_group"
  }
}
#create rds instance
resource "aws_db_instance" "rds_instance" {
  identifier           = "rds-instance"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  storage_encrypted    = true
  multi_az             = true
}
 data "aws_db_instance" "rds_instance_data"{
   db_instance_identifier = aws_db_instance.rds_instance.identifier
 }
 output "endpoint" {
   value = data.aws_db_instance.rds_instance_data.endpoint
 }
output "username"{
  value = var.db_user
   }
output "password"{
value = var.db_password
}
output "db_name"{
  value = data.aws_db_instance.rds_instance_data.db_name
}