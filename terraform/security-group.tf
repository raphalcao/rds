resource "aws_security_group" "rds_sg" {
  count       = 1
  name        = "rds-sg"
  description = "Security Group para RDS MySQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["172.31.16.0/20"]  # ⚠️ Substitua pelo IP da sua aplicação
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.16.0/20"]
  }

  lifecycle {
    prevent_destroy = true
  }
}
