variable "network_info" {
    type = object({
      name = string
      cidr = string
    })
  
}

variable "public_subnets" {
    type = list(object({
        name = string
        cidr = string
        az   = string
    }))
  
}

variable "private_subnets" {
    type = list(object({
        name = string
        cidr = string
        az   = string
}))
  
}

