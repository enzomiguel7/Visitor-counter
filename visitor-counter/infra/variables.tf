variable "db_user" {
  type    = string
  default = "senseflowadmin"
}

variable "db_pass" {
  type      = string
  sensitive = true
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
