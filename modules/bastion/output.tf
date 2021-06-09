output "bastion_id_out" {
  value = aws_instance.bastion.id
}

output "eip_id_out" {
  value = aws_eip.bastion_eip.id
}

output "eip_public_ip_out" {
  value = aws_eip.bastion_eip.public_ip
}
