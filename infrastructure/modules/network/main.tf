#creates the vpc for the application
resource "aws_vpc" "app-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.project}-vpc"
  }
}
# creates the internet gateway for the application so that traffic can flow in and out of the vpc
resource "aws_internet_gateway" "app-igw" {
  vpc_id = aws_vpc.app-vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}

#creates the subnet within the vpc for the application
resource "aws_subnet" "app-subnet" {
  vpc_id            = aws_vpc.app-vpc.id
  cidr_block        = "10.0.0.0/16"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.project}-subnet"
  }
}

#creates the route table for the application so that traffic can flow in and out of the vpc
resource "aws_route_table" "app-route-table" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-igw.id
  }
}

#associates the route table with the subnet
resource "aws_route_table_association" "app-route-table-association" {
  subnet_id      = aws_subnet.app-subnet.id
  route_table_id = aws_route_table.app-route-table.id
}

#creates the loadbalancer for the application
resource "aws_lb" "app-lb" {
  name               = "${var.project}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app-sg.id]
  subnets            = [aws_subnet.app-subnet.id]

  tags = {
    Name        = "${var.project}-lb"
    Environment = "${var.environment}"
  }
}

#creates the security group for the application
resource "aws_security_group" "app-sg" {
  vpc_id      = aws_vpc.app-vpc.id
  name        = "${var.project}-sg"
  description = "Security group for the application"

  tags = {
    Name        = "${var.project}-sg"
    Environment = "${var.environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.app-sg.id
  cidr_ipv4         = aws_vpc.app-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
#   security_group_id = aws_security_group.app-sg.id
#   cidr_ipv6         = aws_vpc.app-vpc.ipv6_cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.app-sg.id
  cidr_ipv4         = aws_vpc.app-vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6" {
#   security_group_id = aws_security_group.app-sg.id
#   cidr_ipv6         = aws_vpc.app-vpc.ipv6_cidr_block
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.app-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.app-sg.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

#creates the target group for the application
resource "aws_lb_target_group" "app-tg" {
  name     = "${var.project}-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.app-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }
}