provider "aws" {
  region = "eu-west-2"
}

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-java-app1"
}
