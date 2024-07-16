# Configure the AWS provider
provider "aws" {
  region = "eu-west-2"
}

# ECR Repository
module "ecr" {
  source = "./modules/ecr"
}

# IAM Role for ECS Task Execution
module "iam" {
  source = "./modules/iam"
}

# Networking (VPC, Subnets, Security Groups)
module "network" {
  source = "./modules/network"
}

# ECS Cluster, Task Definition, and Service
module "ecs" {
  source = "./modules/ecs"
  ecr_repository_url = ""
}

# Outputs
output "ecs_service_endpoint" {
  value = module.ecs.ecs_service_endpoint
}

# module "ecs" {
#   source = "./modules/ecs"
# }

# module "network" {
#   source = "./modules/network"
# }


output "ecs_task_execution_role_arn" {
  value = module.iam.ecs_task_execution_role_arn
}

output "ecs_task_execution_role_policy_attachment_id" {
  value = module.iam.ecs_task_execution_role_policy_attachment_id
}





output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}

output "ecs_service_arn" {
  value = module.ecs.ecs_service_arn
}

output "ecs_task_definition_arn" {
  value = module.ecs.ecs_task_definition_arn
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "security_group_id" {
  value = module.network.security_group_id
}

