resource "aws_ecs_service" "app-service" {
  name            = "${var.application}-service"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs_service_role.arn


  load_balancer {
    target_group_arn = aws_lb_target_group.app-tg.arn
    container_name   = "${var.application}-container"
    container_port   = 3000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-west-1a]"
  }
}
