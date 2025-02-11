variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "ID da VPC onde o RDS será criado"
  type        = string
}

variable "private_subnets" {
  description = "Lista de subnets privadas para o RDS"
  type        = list(string)
}

variable "app_ip" {
  description = "IP da aplicação que pode acessar o banco de dados"
  type        = string
}