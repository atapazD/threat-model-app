resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = {
    Application = "${var.application}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
  }
  # In terms of monitoring, we can enable container insights for the cluster or enhanced container insights for more detailed monitoring. For sake of cost for we will keep the default of using standard cloud watch logs.
}

resource "aws_ecs_cluster_capacity_providers" "app-capacity-providers" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
