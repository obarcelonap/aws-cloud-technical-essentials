data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "tls_private_key" "employee_directory_app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "employee_directory_app_key_pair" {
  key_name   = "employee_directory_app"
  public_key = tls_private_key.employee_directory_app_key.public_key_openssh
}

resource "aws_iam_instance_profile" "employee_directory_app_profile" {
  name = "employee_directory_app_profile"
  role = aws_iam_role.ec2_s3_dynamodb_full_access_role.name
}

resource "aws_instance" "employee_directory_app" {
  ami           = data.aws_ami.latest_amazon_linux_2.id
  instance_type = "t2.micro"

  key_name                    = aws_key_pair.employee_directory_app_key_pair.key_name
  iam_instance_profile        = aws_iam_instance_profile.employee_directory_app_profile.name
  subnet_id                   = aws_default_subnet.default_use1_subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.http_access.name]

  user_data = <<EOF
  #!/bin/bash -ex
  wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/DEV-AWS-MO-GCNv2/FlaskApp.zip
  unzip FlaskApp.zip
  cd FlaskApp/
  yum -y install python3 mysql
  pip3 install -r requirements.txt
  amazon-linux-extras install epel
  yum -y install stress
  export PHOTOS_BUCKET=us-east-1
  export AWS_DEFAULT_REGION=<INSERT REGION HERE>
  export DYNAMO_MODE=on
  FLASK_APP=application.py /usr/local/bin/flask run --host=0.0.0.0 --port=80
EOF

  tags = {
    name = "employee-directory-app"
  }
}