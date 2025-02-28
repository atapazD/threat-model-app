# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.app-vpc.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.app-vpc.cidr_block
}

# Subnet Outputs
output "subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.app-subnet.id
}

output "subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.app-subnet.cidr_block
}

# Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.app-igw.id
}

# Route Table
output "route_table_id" {
  description = "The ID of the Route Table"
  value       = aws_route_table.app-route-table.id
}

# Security Group
output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.app-sg.id
}

# Load Balancer
output "load_balancer_arn" {
  description = "The ARN of the Load Balancer"
  value       = aws_lb.app-lb.arn
}

output "load_balancer_dns" {
  description = "The DNS name of the Load Balancer"
  value       = aws_lb.app-lb.dns_name
}

output "load_balancer_zone_id" {
  description = "The zone ID of the Load Balancer"
  value       = aws_lb.app-lb.zone_id
}

# Target Group
output "target_group_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.app-tg.arn
}
