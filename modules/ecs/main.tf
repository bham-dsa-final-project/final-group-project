provider "aws" {
  region = "eu-west-2"
}

# ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-ecs-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "my-ecs-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "my-java-container"
      image     = "${var.ecr_repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

# Security Group
resource "aws_security_group" "terraform_security_group" {
  name        = "TerreformGroupProject"
  description = "TerreformGroupProject"
  vpc_id      = aws_vpc.vpc_group_project.id

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform_security_group"
  }
}

# Data source for availability zones
data "aws_availability_zones" "group_subnet" {}

# Subnets
resource "aws_subnet" "group_work_public_subnet" {
  count             = var.subnet_count["public"]
  vpc_id            = aws_vpc.vpc_group_project.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.group_subnet.names[count.index]

  tags = {
    Name = "group_work_public_subnet_${count.index}"
  }
}

resource "aws_subnet" "group_work_private_subnet" {
  count             = var.subnet_count["private"]
  vpc_id            = aws_vpc.vpc_group_project.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.group_subnet.names[count.index]

  tags = {
    Name = "group_work_private_subnet_${count.index}"
  }
}

# ECS Service
resource "aws_ecs_service" "ecs_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.group_work_public_subnet[*].id
    security_groups = [aws_security_group.terraform_security_group.id]
    assign_public_ip = true
  }
}

# Outputs
output "ecs_service_endpoint" {
  value = aws_ecs_service.ecs_service.endpoint
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.ecs_task.arn
}
