terraform {
  required_providers {
    aws = {
        source = "hashicrop/aws"
        version = "5.49.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
    default_tags{
        tags = {
            createdby = "terraform"
            environment = "Dev"
        }
    }
  
}