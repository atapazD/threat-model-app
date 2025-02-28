variable "cluster_name" {
  type        = string
  default     = "default-cluster"
  description = "name for the cluster to be created"
}
variable "application" {
  type        = string
  default     = "default-application"
  description = "Application name"
}

variable "project" {
  type        = string
  default     = "default-project"
  description = "Project name"
}

variable "owner" {
  type        = string
  default     = "default-owner"
  description = "Owner of the created resource"
}