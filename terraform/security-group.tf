# 🔍 Verifica se o Security Group "rds-sg" já existe
data "aws_security_group" "existing_rds_sg" {
  filter {
    name   = "group-name"
    values = ["rds-sg"]
  }
}

# 🏗️ Cria o Security Group apenas se ele não existir
resource "aws_security_group" "rds_sg" {
  count       = length(try(data.aws_security_group.existing_rds_sg.id, "")) > 0 ? 0 : 1
  name        = "rds-sg"
  description = "Security Group para RDS MySQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ Ajuste para IP da sua aplicação
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = true
  }
}
