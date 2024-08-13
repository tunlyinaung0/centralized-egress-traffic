resource "aws_subnet" "private_subnet_a" {
    vpc_id            = var.vpc_a
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "A-private-subnet"
    }
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id            = var.vpc_b
    cidr_block        = "10.1.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "B-private-subnet"
    }
}

resource "aws_subnet" "private_subnet_c" {
    vpc_id            = var.vpc_c
    cidr_block        = "10.2.0.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "C-private-subnet"
    }
}

resource "aws_subnet" "public_subnet_c" {
    vpc_id            = var.vpc_c
    cidr_block        = "10.2.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "C-public-subnet"
    }
}

resource "aws_internet_gateway" "igw_c" {
    vpc_id = var.vpc_c

    tags = {
        Name = "C-igw"
    }
}

resource "aws_eip" "for_nat_c" {
    domain = "vpc"

    tags = {
        Name = "C-eip"
    }
}

resource "aws_nat_gateway" "nat_c" {
    subnet_id = aws_subnet.public_subnet_c.id
    allocation_id = aws_eip.for_nat_c.id
}

resource "aws_route_table" "private_rtb_a" {
    vpc_id = var.vpc_a

    route {
        cidr_block = "0.0.0.0/0"
        transit_gateway_id = var.tgw_id
    }
    
    tags = {
        Name = "A-private-rtb"
    }
}

resource "aws_route_table" "private_rtb_b" {
    vpc_id = var.vpc_b

    route {
        cidr_block = "0.0.0.0/0"
        transit_gateway_id = var.tgw_id
    }
    
    tags = {
        Name = "B-private-rtb"
    }
}

resource "aws_route_table" "private_rtb_c" {
    vpc_id = var.vpc_c

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_c.id
    }

    route {
        cidr_block = var.cidr_a
        transit_gateway_id = var.tgw_id
    }

    route {
        cidr_block = var.cidr_b
        transit_gateway_id = var.tgw_id
    }
    
    tags = {
        Name = "C-private-rtb"
    }
}

resource "aws_route_table" "public_rtb_c" {
    vpc_id = var.vpc_c

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_c.id
    }

    route {
        cidr_block = var.cidr_a
        transit_gateway_id = var.tgw_id
    }

    route {
        cidr_block = var.cidr_b
        transit_gateway_id = var.tgw_id
    }

    tags = {
        Name = "C-public-rtb"
    }
}

resource "aws_route_table_association" "private_subnet_a_association" {
    subnet_id = aws_subnet.private_subnet_a.id
    route_table_id = aws_route_table.private_rtb_a.id
}

resource "aws_route_table_association" "private_subnet_b_association" {
    subnet_id = aws_subnet.private_subnet_b.id
    route_table_id = aws_route_table.private_rtb_b.id
}

resource "aws_route_table_association" "private_subnet_c_association" {
    subnet_id = aws_subnet.private_subnet_c.id
    route_table_id = aws_route_table.private_rtb_c.id
}

resource "aws_route_table_association" "public_subnet_c_association" {
    subnet_id = aws_subnet.public_subnet_c.id
    route_table_id = aws_route_table.public_rtb_c.id
}

data "aws_security_group" "sg_a" {
    vpc_id = var.vpc_a

}

resource "aws_security_group_rule" "sg_a_rule" {
    security_group_id = data.aws_security_group.sg_a.id
    type = "ingress"
    from_port = 0 
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

data "aws_security_group" "sg_b" {
    vpc_id = var.vpc_b
}

resource "aws_security_group_rule" "sg_b_rule" {
    security_group_id = data.aws_security_group.sg_b.id
    type = "ingress"
    from_port = 0 
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

data "aws_security_group" "sg_c" {
    vpc_id = var.vpc_c  
}

resource "aws_security_group_rule" "sg_c_rule" {
    security_group_id = data.aws_security_group.sg_c.id
    type = "ingress"
    from_port = 0 
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}