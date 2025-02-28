resource "aws_ecr_repository" "repository" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE" # This is to ensure that the image tags are unchangable

  image_scanning_configuration {
    scan_on_push = true
  }
}