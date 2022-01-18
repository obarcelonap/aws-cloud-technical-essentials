resource "aws_default_vpc" "default_vpc" {
}

resource "aws_security_group" "http_access" {
  name        = "http_access"
  description = "Allow HTTP"

  vpc_id = aws_default_vpc.default_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_default_subnet" "default_use1_subnet" {
  availability_zone = "us-east-1a"
}
