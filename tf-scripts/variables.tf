
#------------------------------------------------------------------------------
# AWS Region
#------------------------------------------------------------------------------

variable "region" {
  description = "The region where you want to deploy your resources."
}

#------------------------------------------------------------------------------
# AWS Networking
#------------------------------------------------------------------------------

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the LB."
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet IDs to attach to the LB if it is NOT internal."
  type        = list(string)
}

#------------------------------------------------------------------------------
# ECS Task Definition
#------------------------------------------------------------------------------

variable "container_image" {
  description = "The latest container image uri available on ECR"
  type        = string
}
