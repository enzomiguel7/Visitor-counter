resource "aws_ecs_cluster" "senseflow_cluster" {
  name = "senseflow-cluster"
}

# Backend Task
resource "aws_ecs_task_definition" "backend" {
  family                   = "senseflow-backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "<SEU_USUARIO_DOCKER_HUB>/backend:latest"
      essential = true
      portMappings = [
        { containerPort = 3000, hostPort = 3000, protocol = "tcp" }
      ]
      environment = [
        { name = "DB_HOST", value = aws_db_instance.mariadb.address },
        { name = "DB_USER", value = var.db_user },
        { name = "DB_PASS", value = var.db_pass },
        { name = "DB_NAME", value = "RegistrosSensor" },
        { name = "MQTT_BROKER_URL", value = "mqtt://mosquitto:1883" }
      ]
    }
  ])
}

# Backend Service
resource "aws_ecs_service" "backend" {
  name            = "backend-svc"
  cluster         = aws_ecs_cluster.senseflow_cluster.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.senseflow_public_subnet.id]
    security_groups = [aws_security_group.sg_backend.id]
    assign_public_ip = true
  }
}

# Mosquitto Task
resource "aws_ecs_task_definition" "mosquitto" {
  family                   = "senseflow-mosquitto"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "mosquitto"
      image     = "eclipse-mosquitto:2.0"
      essential = true
      portMappings = [
        { containerPort = 1883, hostPort = 1883, protocol = "tcp" }
      ]
    }
  ])
}

# Mosquitto Service
resource "aws_ecs_service" "mosquitto" {
  name            = "mosquitto-svc"
  cluster         = aws_ecs_cluster.senseflow_cluster.id
  task_definition = aws_ecs_task_definition.mosquitto.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.senseflow_public_subnet.id]
    security_groups = [aws_security_group.sg_mosquitto.id]
    assign_public_ip = true
  }
}
