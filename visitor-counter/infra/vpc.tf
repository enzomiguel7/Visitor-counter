# Criar VPC
resource "aws_vpc" "senseflow_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "senseflow-vpc"
  }
}

# Criar Internet Gateway
resource "aws_internet_gateway" "senseflow_igw" {
  vpc_id = aws_vpc.senseflow_vpc.id
  tags = {
    Name = "senseflow-igw"
  }
}

# Criar Subnet pública
resource "aws_subnet" "senseflow_public_subnet" {
  vpc_id                  = aws_vpc.senseflow_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "senseflow-public-subnet"
  }
}

# Criar Route Table
resource "aws_route_table" "senseflow_rt" {
  vpc_id = aws_vpc.senseflow_vpc.id
  tags = {
    Name = "senseflow-rt"
  }
}

# Associar a Subnet pública com a Route Table
resource "aws_route_table_association" "senseflow_public_assoc" {
  subnet_id      = aws_subnet.senseflow_public_subnet.id
  route_table_id = aws_route_table.senseflow_rt.id
}

# Criar rota para internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.senseflow_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.senseflow_igw.id
}
