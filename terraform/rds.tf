# 🔍 Referência ao Security Group existente
data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["rds-sg"]  # Nome do security group já existente
  }
}

# 🔍 Referência ao Subnet Group existente
data "aws_db_subnet_group" "existing_subnet_group" {
  name = "rds-subnet-group"  # Nome do DB Subnet Group já existente
}

# 📌 **Criação da Instância do RDS (sem criar Subnet/Security Group)**
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
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

  skip_final_snapshot   = true
}
