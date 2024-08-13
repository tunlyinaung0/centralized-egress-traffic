resource "aws_vpc" "vpc_a" {
    cidr_block = var.cidr_a

    tags = {
        Name = "A-vpc"
    }
}

resource "aws_vpc" "vpc_b" {
    cidr_block = var.cidr_b

    tags = {
        Name = "B-vpc"
    }
}

resource "aws_vpc" "vpc_c" {
    cidr_block = var.cidr_c

    tags = {
        Name = "C-vpc"
    }
}

module "subnets" {
    source = "./modules/subnets"

    vpc_a = aws_vpc.vpc_a.id
    vpc_b = aws_vpc.vpc_b.id
    vpc_c = aws_vpc.vpc_c.id

    cidr_a = var.cidr_a
    cidr_b = var.cidr_b

    tgw_id = module.transit_gateway.tgw_id
}

module "transit_gateway" {
    source = "./modules/transit_gateway"

    vpc_a = aws_vpc.vpc_a.id
    vpc_b = aws_vpc.vpc_b.id
    vpc_c = aws_vpc.vpc_c.id

    private_subnet_a = module.subnets.private_subnet_a
    private_subnet_b = module.subnets.private_subnet_b
    private_subnet_c = module.subnets.private_subnet_c

    cidr_a = var.cidr_a
    cidr_b = var.cidr_b
}


module "ec2" {
    source = "./modules/ec2"

    ami = var.ami
    instance_type = var.instance_type
    private_subnet_a = module.subnets.private_subnet_a
    private_subnet_b = module.subnets.private_subnet_b
    sg_a = module.subnets.sg_a
    sg_b = module.subnets.sg_b
    key_name = var.key_name
}