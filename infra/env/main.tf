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

output "employee_directory_instance_public_ip" {
  value       = module.employee_directory_app.employee_directory_instance_public_ip
  description = "The public ip address of the EC2 instance where the employee directory app is hosted."
}

output "employee_directory_app_instance_private_key" {
  value       = module.employee_directory_app.employee_directory_instance_private_key
  description = "The private key of the EC2 instance where the employee directory app is hosted."
  sensitive   = true
}
