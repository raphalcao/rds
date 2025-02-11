# 🔍 Referência ao Subnet Group existente (se já estiver criado)
data "aws_db_subnet_group" "existing_subnet_group" {
  name = "vpc-08622ed23697cddcd"  # Nome do Subnet Group já existente na AWS
}

# 📌 **Força a Subnet Específica**
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

  # 🔹 Usa o Subnet Group existente
  db_subnet_group_name = data.aws_db_subnet_group.existing_subnet_group.name

  # 🔹 Usa o Security Group existente
  vpc_security_group_ids = ["data.aws_security_group.existing_sg.id"]

  skip_final_snapshot   = true
}

# 🔹 Força o uso da Subnet `subnet-0814e78f75045a3ad`
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["subnet-0814e78f75045a3ad"]  # ⚠️ Alterado para usar apenas essa Subnet

  lifecycle {
    prevent_destroy = true
  }
}
