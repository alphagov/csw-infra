##
# set variables which may differ between environments and deployments

tool = "csw"
environment = "<environment name>"
prefix = "${var.tool}-${var.environment}"
host_account_id = "<insert account_id the env runs in>"

region = "eu-west-2"
# these are not used at present but we could switch to define things using count across this array
availability_zones = ["${var.region}a","${var.region}b"]

# 10.1 Andrea 
# 10.2 Tom 
# 10.3 Sergio 
# 10.4 Dan
# 10.5 Rumy
# 10.6 Deniz
# 10.7 Ares

# 10.100 UAT
# 10.200 Live

ip_16bit_prefix = "<insert ip prefix>" 

postres_root_password = "<insert root password>"

ssh_key_name = "<key name>"
ssh_public_key_path = "<path to ssh public key file>"