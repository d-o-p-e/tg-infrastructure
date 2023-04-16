output "vpc_id" {
  value = aws_vpc.dope_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}