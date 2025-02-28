output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.cluster.id
}

output "cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.cluster.name
}

output "cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = aws_ecs_cluster.cluster.arn
}

output "capacity_providers" {
  description = "The capacity providers associated with the cluster"
  value       = aws_ecs_cluster_capacity_providers.app-capacity-providers.capacity_providers
}
