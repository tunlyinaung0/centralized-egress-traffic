resource "aws_ec2_transit_gateway" "tgw" {
    description = "tgw"
    default_route_table_association = "disable"
    default_route_table_propagation = "disable"

    tags = {
        Name = "tgw"
    }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment_a" {
    subnet_ids = [ var.private_subnet_a ]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id = var.vpc_a

    tags = {
        Name = "A-attachment"
    }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment_b" {
    subnet_ids = [ var.private_subnet_b ]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id = var.vpc_b

    tags = {
        Name = "B-attachment"
    }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment_c" {
    subnet_ids = [ var.private_subnet_c ]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id = var.vpc_c

    tags = {
        Name = "C-attachment"
    }
}

resource "aws_ec2_transit_gateway_route_table" "tgw_rtb_ab" {
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id

    tags = {
        Name = "AB-tgw-rtb"
    }
}

resource "aws_ec2_transit_gateway_route_table" "tgw_rtb_c" {
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id

    tags = {
        Name = "C-tgw-rtb"
    }
  
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_rtb_association_a" {
    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.attachment_a.id
    transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rtb_ab.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_rtb_association_b" {
    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.attachment_b.id
    transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rtb_ab.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw_rtb_association_c" {
    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.attachment_c.id
    transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rtb_c.id 
}


resource "aws_ec2_transit_gateway_route" "tgw_rt_ab" {
    destination_cidr_block = "0.0.0.0/0"
    transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rtb_ab.id
    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.attachment_c.id
}

resource "aws_ec2_transit_gateway_route" "tgw_rt_c1" {
    destination_cidr_block = var.cidr_a
    transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rtb_c.id
    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.attachment_a.id
}

resource "aws_ec2_transit_gateway_route" "tgw_rt_c2" {
    destination_cidr_block = var.cidr_b
    transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rtb_c.id
    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.attachment_b.id
}