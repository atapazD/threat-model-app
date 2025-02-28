output "service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.app-service.id
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.app-service.name
}

output "service_arn" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.app-service.arn
}

output "task_definition" {
  description = "Task definition ARN associated with the service"
  value       = aws_ecs_service.app-service.task_definition
}

output "cluster_id" {
  description = "The ECS cluster ID where the service is running"
  value       = aws_ecs_service.app-service.cluster
}

output "load_balancer_target_group" {
  description = "The Target Group ARN associated with the ECS service"
  value       = aws_lb_target_group.app-tg.arn
}
