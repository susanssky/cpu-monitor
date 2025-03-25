provider "aws" {}

terraform {
  backend "s3" {
    bucket = "my-cloud-projects-tfstate"
    key    = "4-cpu-monitor-backend.tfstate"
    region = "eu-west-2"
  }
}
