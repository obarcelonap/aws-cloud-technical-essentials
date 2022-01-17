terraform {
  required_version = "= 1.1.3"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      course = "aws-cloud-technical-essentials"
    }
  }
}

module "employee_directory_app" {
  source = "../modules/employee-directory-app"
}
