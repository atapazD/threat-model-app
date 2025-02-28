module "ecr" {
  source          = "../modules/ecr"
  repository_name = "threatAppRepository"
}

module "ecs" {
  source       = "../modules/ecs"
  cluster_name = "threatAppCluster"
  application  = "threatApp"
  project      = "threatApp"
  owner        = "dz"
}
module "ecs_service" {
  source = "../modules/ecs_service"
}

module "ecs-task" {
  source = "../modules/ecs_task"
}

module "network" {
  source      = "../modules/network"
  environment = "dev"
}


