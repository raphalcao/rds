# 🔍 Verifica se o DB Subnet Group já existe
data "aws_db_subnet_group" "existing_subnet_group" {
  name = "rds-subnet-group"
}

# 🏗️ Cria o DB Subnet Group apenas se não existir
resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = length(try(data.aws_db_subnet_group.existing_subnet_group.id, [])) > 0 ? 0 : 1
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets

  lifecycle {
    prevent_destroy = true
  }
}

# 📌 **Criação da Instância do RDS**
resource "aws_db_instance" "rds_mysql" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  identifier           = "rds-auth-db"
  username             = var.db_username
  password             = var.db_password
  publicly_accessible   = false

  db_subnet_group_name = length(try(data.aws_db_subnet_group.existing_subnet_group.id, "")) > 0 
                      ? data.aws_db_subnet_group.existing_subnet_group.id 
                      : aws_db_subnet_group.rds_subnet_group[0].id

  vpc_security_group_ids = length(try(data.aws_security_group.existing_sg.id, "")) > 0 
                        ? [data.aws_security_group.existing_sg.id] 
                        : [aws_security_group.rds_sg[0].id]

  skip_final_snapshot   = true
}
