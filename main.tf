provider "aws" {
    region = "us-east-2"
  
}

resource "aws_db_instance" "prod" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "administrator"
  password             = random_password.main.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

# Generate Password
resource "random_password" "main" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# # Store Passowrd
# resource "aws_secretsmanager_secret" "rds_password" {
#   name = "mydb_passowrd"
#   description = "Password for my RDS database"
#   recovery_window_in_days = 0 # it delete the passowrd immediately
# }


#......... output
output "rds_address" {
  value = aws_db_instance.prod.address
}

output "rds_port" {
    value = aws_db_instance.prod.port
  
}

output "rds_username" {
    value = aws_db_instance.prod.username
  
}

output "rds_password" {
    value = random_password.main.result
    sensitive = true
  
}