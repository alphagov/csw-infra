##
# creates a key-pair in AWS

resource "aws_key_pair" "key-pair" {
  key_name   = var.ssh_key_name
  public_key = trimspace(file(var.ssh_public_key_path))
}
