
resource "aws_security_group" "dope-db-sg" {
  name        = "${var.environment}-db-sg"
  description = "RDS Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "public access to db"
    protocol  = "TCP"
    from_port = 3306
    to_port   = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "dope-${var.environment}-db-sg"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "dope_db_subnet_group" {
  name       = "dope-db-${var.environment}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "dope-db-${var.environment}-subnet-group"
  }
}

resource "aws_db_instance" "dope-db" {
    instance_class = "db.t3.micro"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0.32"
    identifier = "dope-${var.environment}-db"
    db_name = "dope_${var.environment}_db"
    username = var.db_username
    password = var.db_password
    publicly_accessible = true
    multi_az = false
    auto_minor_version_upgrade = true
    port = 3306
    skip_final_snapshot = true
    backup_retention_period = 0
    vpc_security_group_ids = [aws_security_group.dope-db-sg.id]
    availability_zone = "ap-northeast-2a"
    db_subnet_group_name = aws_db_subnet_group.dope_db_subnet_group.name
    
    tags = {
        Name = "dope-${var.environment}-db"
    }
}