output "employee_directory_instance_public_ip" {
  value     = aws_instance.employee_directory_app.public_ip
}

output "employee_directory_instance_private_key" {
  value     = tls_private_key.employee_directory_app_key.private_key_pem
  sensitive = true
}
