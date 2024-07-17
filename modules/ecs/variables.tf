variable "ecr_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}


variable "subnet_count" {
  description = "Number of public subnets to create"
  type        = number
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Adjust the default values as requirements
}


variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Adjust the default values as requirements
}

# variable "vpc_id" {
#   description = "The VPC ID"
#   type        = string
# }

# variable "ec2_security_group_ingress" {
#   description = "Ingress rules for EC2 security group"
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
# }

# variable "rds_security_group_ingress" {
#   description = "Ingress rules for RDS security group"
#   type = list(object({
#     from_port       = number
#     to_port         = number
#     protocol        = string
#     security_groups = list(string)
#   }))
# }

# variable "elb_security_group_ingress" {
#   description = "Ingress rules for ELB security group"
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
# }




variable "list_of_ports" {
  description = "List of ports to allow ingress traffic"
  type        = list(number)
  default     = [22, 80, 443]  # Example default values, adjust as per your requirements
}

variable "all_ip_cidr" {
  description = "CIDR block to allow traffic from"
  type        = string
  default     = "0.0.0.0/0"  # Example default value, adjust as per your requirements
}








