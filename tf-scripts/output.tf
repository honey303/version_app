#------------------------------------------------------------------------------
# ALB
#------------------------------------------------------------------------------
output "aws_lb_arn" {
  description = "The ARN of the LB"
  value       = aws_lb.poc_lb.arn
}

output "aws_lb_target_group_arn" {
  description = "The ARN of the LB target group"
  value       = aws_lb_target_group.ip_tg.arn
}

output "aws_lb_listener_arn" {
  description = "The Amazon Resource Name (ARN) of the ALB listener"
  value       = aws_lb_listener.sample_app.arn
}

#------------------------------------------------------------------------------
# ECS Task Definition
#------------------------------------------------------------------------------

# ECS Task Definition ARN
output "aws_ecs_task_definition_arn" {
  description = "The ARN of the LB target group"
  value       = aws_ecs_task_definition.service.arn
}

# ECS Task Definition Revision
output "aws_ecs_task_definition_revision" {
  description = "The revision of the LB target group"
  value       = aws_ecs_task_definition.service.revision
}

#------------------------------------------------------------------------------
# ECS Service & Cluster
#------------------------------------------------------------------------------

# ECS Service ARN
output "aws_ecs_service_arn" {
  description = "The ARN of the AWS ECS service"
  value       = aws_ecs_service.svc.id
}

# ECS Cluster ARN
output "aws_ecs_cluster_arn" {
  description = "The ARN of the AWS ECS cluster"
  value       = aws_ecs_cluster.cluster.arn
}

#------------------------------------------------------------------------------
# IAM 
#------------------------------------------------------------------------------

output "aws_iam_role_arn" {
  description = "The ARN of the IAM task execution role"
  value       = aws_iam_role.role.arn
}

output "aws_iam_role_name" {
  description = "The name of the IAM task execution role"
  value       = aws_iam_role.role.name
}