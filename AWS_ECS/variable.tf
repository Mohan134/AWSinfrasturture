variable "region1" {
    description = "region for environment"
    type = string
    default = "us-west-1"
  
}

variable "app_image" {
    description = "docker image to run in ecs defination"
    default = "centos:latest"
  
}

variable "vpc_name" {
    description = "name of vpc"
    type = string
    default = "ecs-vpc"
  
}

variable "vpc_cidr" {
    description = "vpc-cidr"
    type = string
    default = "10.0.0.0/16"
  
}

variable "public_subnet1" {
    description = "public subnet1 cidr block"
    type = string 
    default = "10.0.1.0/24"
  
}

variable "public_subnet2" {
    description = "public subnet 2 cidr block"
    type = string
    default = "10.0.2.0/24"
  
}

variable "private_subnet1" { 
    description = "private subnet1 cidr block"
    type = string
    default = "10.0.4.0/24"
  
}


// terraform init 
// terraform plan 
// terraform fmt useful to clean up spaces and make the code loook cleaner 
// terraform apply 