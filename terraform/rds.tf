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
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group[0].name
  vpc_security_group_ids = [aws_security_group.rds_sg[0].id]
  skip_final_snapshot   = true
}

data "aws_db_subnet_group" "existing_subnet_group" {
  name = "rds-subnet-group"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = length(data.aws_db_subnet_group.existing_subnet_group) > 0 ? 0 : 1
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets

  lifecycle {
    prevent_destroy = true
  }
}

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
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = true
  }
}
