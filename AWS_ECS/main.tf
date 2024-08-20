resource "aws_ecs_cluster" "ecs_cluster" {
    name = "project_ecs"
  
}

resource "aws_ecs_capacity_providers" "ecs_provider" {
    cluster_name = aws_ecs_cluster.ecs_cluster.name 
    capacity_providers = ["FARGATE"]

    default_capacity_provider_strategy {
        base = 1 
        weight = 100
        capacity_provider = "FARGATE"
    }
  
}

resource "aws_ecs_task_defination" "ecs" {
    family = "ecs"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = "1024"
    Memory = "2048"

    container_definations = jsoncode([
        {
            requires_compatibilities = ["FARGATE"]
            cpu                      = 256
            image                    = "centos:latest"
            network_mode             = "awsvpc"
            memory                   = 512 
            essential                = true 
            name                     = "ecs"
            container_port           = "8080"
        }
    ])
  
}

resource "aws_ecs_service" "aws-ecs-service" {
    name = "ecs-service"
    cluster = aws_ecs_cluster.ecs_cluster.id 
    task_definition = aws_ecs_task_defination.ecs.arn 
    launch_type = "FARGATE"
    scheduling_strategy = "Replica"
    desired_count = 1
    force_new_deployment = true 

    network_configuration {
      subnets = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
      assign_public_ip = false 
      security_groups = [
        aws_security_group.service_security_group.id,
        aws_security.load_balancer_security_group.id
      ]
    }
  
}

resource "aws_alb" "application_load_balancer" {
    name = "ecs-load-balancer"
    internal = false 
    load_balancer_type = "application"
    subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet1.id]
    security_groups = [aws_secuirty_group.load_balancer_security_group.id]

  
}

resource "aws_lb_target_group" "target_group" {
    name = "container-tg"
    port = 80 
    protocol = "Http"
    target_type = "ip"
    vpc_id = aws_vpc.vpc_block.id 

    health_check {
      healthy_threshold = "3"
      interval = "300"
      protocol = "http"
      matcher = "200"
      timeout = "3"
      path = "/v1/status"
      unhealthy_threshold = "2"
    }
  
}

resource "aws_lb_listener" "lister" {
    load_balancer_arn = aws_alb.application_load_balancer.id
    port = "80"
    protocol = "http"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.id
    }
  
}

resource "aws_security_group" "service_secuirty_group" {}

resource "aws_secuirty_group" "load_balancer_security_group" {
    vpc_id = aws_vpc.vpc_block.id 

    ingress {
        from_port = 80
        to_port   = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port = 0 
        to_port   = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
  
}