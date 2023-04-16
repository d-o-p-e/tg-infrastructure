output "vpc_id" {
  value = aws_vpc.dope_vpc.id
}

output "subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}