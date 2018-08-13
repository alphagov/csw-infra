resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.prefix}-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name = "${var.prefix}-igw"
    }
}

/*
  NAT Instance
*/
resource "aws_security_group" "nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [
            "${var.private_subnet_2a_cidr}",
            "${var.private_subnet_2b_cidr}"
        ]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [
            "${var.private_subnet_2a_cidr}",
            "${var.private_subnet_2b_cidr}"
        ]
    }
    ingress {
        from_port = 22
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
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "${var.prefix}-sg-nat"
    }
}

resource "aws_instance" "nat" {
    ami = "ami-0a4c5a6e" # this is a special ami preconfigured to do NAT
    availability_zone = "eu-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "${var.prefix}-ec2-nat"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
    tags {
        Name = "${var.prefix}-nat-eip"
    }
}

/*
  Public Subnets
*/

/* eu-west-2a */
resource "aws_subnet" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_2a_cidr}"
    availability_zone = "eu-west-2a"

    tags {
        Name = "${var.prefix}-public-subnet-2a"
    }
}

resource "aws_route_table" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "${var.prefix}-public-routes-2a"
    }
}

resource "aws_route_table_association" "eu-west-2a-public" {
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    route_table_id = "${aws_route_table.eu-west-2a-public.id}"
}

/* eu-west-2b */
resource "aws_subnet" "eu-west-2b-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_2b_cidr}"
    availability_zone = "eu-west-2b"

    tags {
        Name = "${var.prefix}-public-subnet-2b"
    }
}

resource "aws_route_table" "eu-west-2b-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "${var.prefix}-public-routes-2b"
    }
}

resource "aws_route_table_association" "eu-west-2b-public" {
    subnet_id = "${aws_subnet.eu-west-2b-public.id}"
    route_table_id = "${aws_route_table.eu-west-2b-public.id}"
}

/*
  Private Subnet
*/

/* eu-west-2a */
resource "aws_subnet" "eu-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_2a_cidr}"
    availability_zone = "eu-west-2a"

    tags {
        Name = "${var.prefix}-private-subnet-2a"
    }
}

resource "aws_route_table" "eu-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "${var.prefix}-private-routes-2a"
    }
}

resource "aws_route_table_association" "eu-west-2a-private" {
    subnet_id = "${aws_subnet.eu-west-2a-private.id}"
    route_table_id = "${aws_route_table.eu-west-2a-private.id}"
}

/* eu-west-2b */
resource "aws_subnet" "eu-west-2b-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_2b_cidr}"
    availability_zone = "eu-west-2b"

    tags {
        Name = "${var.prefix}-private-subnet-2b"
    }
}

resource "aws_route_table" "eu-west-2b-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "${var.prefix}-private-routes-2b"
    }
}

resource "aws_route_table_association" "eu-west-2b-private" {
    subnet_id = "${aws_subnet.eu-west-2b-private.id}"
    route_table_id = "${aws_route_table.eu-west-2b-private.id}"
}