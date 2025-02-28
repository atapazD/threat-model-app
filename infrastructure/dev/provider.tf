terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

# Below is for AWS provider

provider "aws" {
  region = "us-east-1"
}


