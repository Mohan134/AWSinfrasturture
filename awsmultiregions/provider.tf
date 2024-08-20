terraform {
  required_providers {
    aws = {
        source = "hashicrop/aws"
        version = "5.49.0"
    }
  }
}


provider "aws" {
    default_tags {
        tags = {
            createby = "terraform"
            environment = "dev"
        }
    }
  
}