output "rds_endpoint" {
  description = "Endereço do banco de dados"
  value       = aws_db_instance.rds_mysql.endpoint
}
