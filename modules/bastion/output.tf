output "bastion_id_out" {
  value = "${aws_instance.bastion.id}"
}

output "bastion_eip_id_out" {
  value = "${aws_eip.bastion_eip.id}"
}
