output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet1_id" {
  description = "ID of public subnet 1"
  value       = aws_subnet.public1.id
}

output "subnet2_id" {
  description = "ID of public subnet 2"
  value       = aws_subnet.public2.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}