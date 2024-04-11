resource "aws_vpc" "nikita-vpc" {
  cidr_block = "10.0.0.0/16"  
  enable_dns_hostnames = true 
  enable_dns_support = true
  
  tags       =  {
    name     = "nikita-vpc"
  }       
}

resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.nikita-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.nikita-vpc.id 
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "private_sub_1" 
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.nikita-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_sub_2"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.nikita-vpc.id 
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private_sub_2" 
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nikita-vpc.id
  tags = {
    Name = "nikita-vpc-igw"
  }
}

resource "aws_route_table" "RB_Public_RouteTable" {
  vpc_id = aws_vpc.nikita-vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "nikita-public-rt"
  }
}

resource "aws_route_table" "RB_Private_RouteTable" {
  vpc_id = aws_vpc.nikita-vpc.id

  # route { 
  #   cidr_block = "0.0.0.0/0"
  #   #nat_gateway_id = aws_nat_gateway.nat-gw.id
  #   #adjust the configuration of the igw to ngw
  # }
  tags = {
    Name = "nikita-private-rt"
  }
}
resource "aws_route_table_association" "Public_Subnet1_Asso" {
  route_table_id = aws_route_table.RB_Public_RouteTable.id
  subnet_id      = aws_subnet.public-1.id
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-1]
}

resource "aws_route_table_association" "Private_Subnet1_Asso" {
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  subnet_id      = aws_subnet.private-1.id
}

resource "aws_route_table_association" "Public_Subnet2_Asso" {
  route_table_id = aws_route_table.RB_Public_RouteTable.id
  subnet_id      = aws_subnet.public-2.id
}

resource "aws_route_table_association" "Private_Subnet2_Asso" {
  route_table_id = aws_route_table.RB_Private_RouteTable.id
  subnet_id      = aws_subnet.private-2.id
}