terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "2.20.0"
    }
  }
}
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.0"
    }
  }
}

provider "docker" {}

provider "aws" {
    region = "us-west-1"
  
}
