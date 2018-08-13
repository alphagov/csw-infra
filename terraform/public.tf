/*
  Web Servers
*/
resource "aws_security_group" "sg-public" {
    name = "${var.prefix}-sg-public"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 0
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 0
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress { 
        from_port = 0
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "213.86.153.212/32",
            "213.86.153.213/32",
            "213.86.153.214/32",
            "213.86.153.235/32",
            "213.86.153.236/32",
            "213.86.153.237/32",
            "85.133.67.244/32"
        ]
    }
    
    egress { # Postgres
        from_port = 0
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = [
            "${var.private_subnet_2a_cidr}",
            "${var.private_subnet_2b_cidr}"
        ]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.prefix}-sg-public"
    }
}


resource "aws_instance" "bastion" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "eu-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.sg-public.id}"]
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "${var.prefix}-bastion"
    }
}


resource "aws_eip" "bastion_eip" {
    instance = "${aws_instance.bastion.id}"
    vpc = true
    tags {
        Name = "${var.prefix}-bastion-eip"
    }
}
