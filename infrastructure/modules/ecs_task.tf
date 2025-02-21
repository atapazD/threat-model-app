resource "aws_ecs_task_definition" "task" {
  family = "${var.application}-task"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  aws_execution_role = aws_iam_role.task_execution_role.arn
  task_role_arn = aws_iam_role.task_role.arn
  
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