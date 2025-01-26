output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}
