resource "aws_vpc" "employee_directory_app_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = "employee_directory_app_vpc"
  }
}

resource "aws_internet_gateway" "employee_directory_app_igw" {
  vpc_id = aws_vpc.employee_directory_app_vpc.id

  tags = {
    name = "employee_directory_app_igw"
  }
}

resource "aws_route_table" "employee_directory_app_route_table_public" {
  vpc_id = aws_vpc.employee_directory_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.employee_directory_app_igw.id
  }

  tags = {
    name = "employee_directory_app_route_table_public"
  }
}

resource "aws_route_table" "employee_directory_app_route_table_private" {
  vpc_id = aws_vpc.employee_directory_app_vpc.id

  tags = {
    name = "employee_directory_app_route_table_private"
  }
}

# Setup for us-east-1a
resource "aws_subnet" "employee_directory_app_public_subnet_use1_az1" {
  vpc_id                  = aws_vpc.employee_directory_app_vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    name = "employee_directory_app_public_subnet_use1_az1"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_public_use1_az1" {
  subnet_id      = aws_subnet.employee_directory_app_public_subnet_use1_az1.id
  route_table_id = aws_route_table.employee_directory_app_route_table_public.id
}

resource "aws_subnet" "employee_directory_app_private_subnet_use1_az1" {
  vpc_id            = aws_vpc.employee_directory_app_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    name = "employee_directory_app_private_subnet_use1_az1"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_private_use1_az1" {
  subnet_id      = aws_subnet.employee_directory_app_private_subnet_use1_az1.id
  route_table_id = aws_route_table.employee_directory_app_route_table_private.id
}

# Setup for us-east-1b
resource "aws_subnet" "employee_directory_app_public_subnet_use1_az2" {
  vpc_id                  = aws_vpc.employee_directory_app_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    name = "employee_directory_app_public_subnet_use1_az2"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_public_use1_az2" {
  subnet_id      = aws_subnet.employee_directory_app_public_subnet_use1_az2.id
  route_table_id = aws_route_table.employee_directory_app_route_table_public.id
}

resource "aws_subnet" "employee_directory_app_private_subnet_use1_az2" {
  vpc_id            = aws_vpc.employee_directory_app_vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.4.0/24"

  tags = {
    name = "employee_directory_app_private_subnet_use1_az2"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_private_use1_az2" {
  subnet_id      = aws_subnet.employee_directory_app_private_subnet_use1_az2.id
  route_table_id = aws_route_table.employee_directory_app_route_table_private.id
}
