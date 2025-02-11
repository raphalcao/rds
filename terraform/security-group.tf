data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["rds-sg"]
  }
}

resource "aws_security_group" "rds_sg" {
  count       = length(data.aws_security_group.existing_sg) > 0 ? 0 : 1
  name        = "rds-sg"
  description = "Security Group para RDS MySQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.app_ip] # 🚀 Altere `var.app_ip` para o IP da aplicação
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
