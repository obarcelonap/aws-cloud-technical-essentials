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

# Setup for first az
resource "aws_subnet" "employee_directory_app_public_subnet_az1" {
  vpc_id                  = aws_vpc.employee_directory_app_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    name = "employee_directory_app_public_subnet_${data.aws_availability_zones.available.zone_ids[0]}"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_public_az1" {
  subnet_id      = aws_subnet.employee_directory_app_public_subnet_az1.id
  route_table_id = aws_route_table.employee_directory_app_route_table_public.id
}

resource "aws_subnet" "employee_directory_app_private_subnet_az1" {
  vpc_id            = aws_vpc.employee_directory_app_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.3.0/24"

  tags = {
    name = "employee_directory_app_private_subnet_${data.aws_availability_zones.available.zone_ids[0]}"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_private_az1" {
  subnet_id      = aws_subnet.employee_directory_app_private_subnet_az1.id
  route_table_id = aws_route_table.employee_directory_app_route_table_private.id
}

# Setup for second az
resource "aws_subnet" "employee_directory_app_public_subnet_az2" {
  vpc_id                  = aws_vpc.employee_directory_app_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[1]
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    name = "employee_directory_app_public_subnet_${data.aws_availability_zones.available.zone_ids[1]}"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_public_az2" {
  subnet_id      = aws_subnet.employee_directory_app_public_subnet_az2.id
  route_table_id = aws_route_table.employee_directory_app_route_table_public.id
}

resource "aws_subnet" "employee_directory_app_private_subnet_az2" {
  vpc_id            = aws_vpc.employee_directory_app_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.4.0/24"

  tags = {
    name = "employee_directory_app_private_subnet_${data.aws_availability_zones.available.zone_ids[1]}"
  }
}

resource "aws_route_table_association" "employee_directory_app_route_table_association_private_az2" {
  subnet_id      = aws_subnet.employee_directory_app_private_subnet_az2.id
  route_table_id = aws_route_table.employee_directory_app_route_table_private.id
}
