output "backend_ip" {
  value = aws_ecs_service.backend.network_configuration[0].assign_public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.mariadb.address
}
