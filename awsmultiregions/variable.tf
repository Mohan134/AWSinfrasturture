variable "primary_network_cidr" {
    type = string
    description = "this is primary network cidr range"
    default = "192.168.0.0/16"
  
}
variable "subnet_cidrs" {
    type = list(string)
    default = [ "192.168.0.0/24", "192.168.1.0/24" ]
  
}
variable "subnet_names" {
    type = list(string)
    default = [ "web", "app", "db" ]
  
}
variable "subnet_azs" {
  
  type = list(string)
  default = [ "ap-south-1a","ap-south-1b", "ap-south-1a" ]
}