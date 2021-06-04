output "vpc_id_out" {
  value = aws_vpc.vpc.id
}

output "igw_id_out" {
  value = aws_internet_gateway.igw.id
}
