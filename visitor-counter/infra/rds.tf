resource "aws_db_subnet_group" "senseflow_db_subnet" {
  name       = "senseflow-db-subnet"
  subnet_ids = [aws_subnet.senseflow_public_subnet.id]  # usando a mesma public subnet para simplicidade
  description = "Subnet group for senseflow RDS"
}

resource "aws_db_instance" "mariadb" {
  identifier             = "senseflow-mariadb"
  allocated_storage      = 20
  engine                 = "mariadb"
  engine_version         = "10.6"
  instance_class         = "db.t3.micro"
  db_name                = "RegistrosSensor"
  username               = var.db_user
  password               = var.db_pass
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  db_subnet_group_name   = aws_db_subnet_group.senseflow_db_subnet.name
}
