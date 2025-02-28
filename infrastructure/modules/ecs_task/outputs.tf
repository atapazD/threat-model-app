output "task_definition_arn" {
  description = "The ARN of the ECS Task Definition"
  value       = aws_ecs_task_definition.task.arn
}

output "task_family" {
  description = "The family name of the ECS Task Definition"
  value       = aws_ecs_task_definition.task.family
}

output "execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  value       = aws_iam_role.task_execution_role.arn
}

output "task_role_arn" {
  description = "The ARN of the ECS Task Role"
  value       = aws_iam_role.ecs_service_role.arn
}
