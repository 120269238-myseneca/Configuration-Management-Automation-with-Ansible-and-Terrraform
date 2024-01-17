resource "aws_vpc" "k8s_cluster" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.k8s_cluster.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.public_subnet_az
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.k8s_cluster.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_subnet_az
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k8s_cluster.id
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.k8s_cluster.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.k8s_cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
