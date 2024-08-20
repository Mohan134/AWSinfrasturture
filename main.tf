// fetch ubuntu ami 
data "aws_ami" "ubuntu" {
    most_recent = true 

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jummy-22.04-amd64-server-*"]
    }
    filter {
      name = "virtulization-type"
      values = ["hvm"]
    }
    owners = ["676386367356356"] // cannonical
}

//fetch key-pairs 
data "aws_key_pair" "id_rsa" {
  key_name  = "var.key_name"
}

data "aws_secuirty_group" "openall" {
  name = "var.secuirty_group_name"
}

data "aws_vpc" "default" {
  default = "true"
}

data "aws_subnet" "web" {
  vpc_id = data.aws_vpc.default.id 
  availability_zone = "var.az"
}

resource "aws_instance" "my-instance" {
  instance_type = "var.instance_type"
  vpc_security_group_ids = [data.aws_security_group.openall.id_rsa]
  subnet_id = data.aws_subnet.web.id 
  count = "var.vpc_id" 
  key_name = data.aws_key_pair.id_rsa.key_name
  ami = "data.aws_ami.ubuntu.id"
  availability_zone = "var.availabilty_zone"
  associate_public_ip_address = "true"
  tags = {
    Name = "preschool"
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("var.key_path")
    host = self.public_ip
  }
  provisioner "remote-exec" {
    script = "install.sh"
    inline = [ 
      "sudo apt update",
      "sudo apt install nginx -y"
     ]
    
  }
  depends_on = [ 
    data.aws_ami.ubuntu,
    data.aws_key_pair.id_rsa,
    data.aws_secuirty_group.openall,
    data.aws_subnet.web
   ]
  
}