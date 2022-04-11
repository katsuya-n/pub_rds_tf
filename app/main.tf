# コマンドライン引数から取得
variable "database_name" {}
variable "db_master_username" {}
variable "db_master_password" {}

provider "aws" {
  region = "us-west-1"

  default_tags {
    tags = {
      System = local.name_prefix
      Owner  = "lightkun"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }
  required_version = "1.1.8"
  backend "s3" {
    bucket = "lightkun-rds-tf-terraform-tfstate-20220410-us-west-1"
    key    = "dev.tfstate"
    region = "us-west-1"
  }
}

module "rds" {
  source             = "../modules/rds"
  name_prefix        = local.name_prefix
  db_az              = [local.az_1a, local.az_1b]
  database_name      = var.database_name
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
  db_num             = 2
  instance_class     = "db.t3.small"
}