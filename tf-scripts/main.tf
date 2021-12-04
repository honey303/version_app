provider "aws" {
    region = var.region

}

# ALB
resource "aws_lb" "poc_lb" {
  name               = "poc-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.public_subnets

  enable_deletion_protection = true

  tags = {
    Environment = "test"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "ip_tg" {
  name        = "poc-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

# ALB Listener
resource "aws_lb_listener" "sample_app" {
  load_balancer_arn = aws_lb.poc_lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_tg.arn
  }
}

# ECS Execution role
resource "aws_iam_role" "role" {
  name = "poc-ecs-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the managed policy AmazonECSTaskExecutionRolePolicy to the role
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ECS Task Definition
resource "aws_ecs_task_definition" "service" {
  family                = "service"
  container_definitions = <<TASK_DEFINITION
  [
      {
        "name": "sample-app",
        "image": "${var.container_image}",
        "cpu": 10,
        "memory": 512,
        "essential": true,
        "portMappings": [
          {
            "containerPort": 80,
            "hostPort": 80
          }
        ]
      }
  ]
  TASK_DEFINITION
  network_mode = "awsvpc"
  cpu = "1024"
  memory = "8192"
  execution_role_arn = aws_iam_role.role.arn
  requires_compatibilities = ["FARGATE"]
}

# ECS Cluster
resource "aws_ecs_cluster" "cluster" {
  name = "poc-ecs-cluster"
}

# AWS ECS Service
resource "aws_ecs_service" "svc" {
  name            = "poc-svc"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"


  network_configuration {
    subnets = var.public_subnets
    assign_public_ip = true
    security_groups = var.security_groups

  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ip_tg.arn
    container_name   = "sample-app"
    container_port   = 80
  }

  depends_on = [
    aws_lb_listener.sample_app,
  ]

}
