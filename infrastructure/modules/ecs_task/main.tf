resource "aws_ecs_task_definition" "task" {
  family                   = "${var.application}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_service_role.arn

  container_definitions = jsonencode([
    {
      name      = "${var.application}-container"
      image     = "${aws_ecr_repository.repository.repository_url}:latest"
      cpu       = 1024
      memory    = 3072
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])

}

resource "aws_iam_role" "ecs_service_role" {
  name = "${var.application}-ecs-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
  tags = {
    Application = "${var.application}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
  }
}

resource "aws_iam_role" "task_execution_role" {
  name = "${var.application}-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
  tags = {
    Application = "${var.application}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
  }
}