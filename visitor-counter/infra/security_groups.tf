# Security Group do Backend ECS
resource "aws_security_group" "sg_backend" {
  name        = "senseflow-backend-sg"
  description = "Permite acesso ao backend e comunicação interna"
  vpc_id      = aws_vpc.senseflow_vpc.id

  # Permitir acesso HTTP ao backend (3000)
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # depois podemos restringir ao ALB
  }

  # Saída liberada
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "senseflow-backend-sg"
  }
}

# Security Group do Mosquitto
resource "aws_security_group" "sg_mosquitto" {
  name        = "senseflow-mosquitto-sg"
  description = "Permite conexões MQTT internas"
  vpc_id      = aws_vpc.senseflow_vpc.id

  # O backend ECS poderá conectar no mosquitto
  ingress {
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    security_groups = [
      aws_security_group.sg_backend.id
    ]
  }

  # Saída liberada
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "senseflow-mosquitto-sg"
  }
}

# Security Group do RDS MariaDB
resource "aws_security_group" "sg_rds" {
  name        = "senseflow-rds-sg"
  description = "Permite acesso ao RDS pelo backend"
  vpc_id      = aws_vpc.senseflow_vpc.id

  # Permitir acesso ao banco apenas para o backend
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [
      aws_security_group.sg_backend.id
    ]
  }

  # Saída liberada
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "senseflow-rds-sg"
  }
}
