terraform {
#   backend "s3" {
#       bucket = "<bucket_name>"
#       encrypt = true
#       key = "terraform.tfstate"
#       region = "us-east-1"
#     }
}

provider "aws" {
  region = "us-east-1"
  # profile = "default"
}