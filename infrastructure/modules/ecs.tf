resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}"
  # Specifying that the cluster should use Fargate capacity providers
    capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Application = "${var.application}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
  }
  # In terms of monitoring, we can enable container insights for the cluster or enhanced container insights for more detailed monitoring. For sake of cost for we will keep the default of using standard cloud watch logs.
}