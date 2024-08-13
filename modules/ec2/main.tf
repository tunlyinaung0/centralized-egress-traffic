resource "aws_instance" "server_a" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.private_subnet_a
    vpc_security_group_ids = [var.sg_a]
    key_name = var.key_name
    iam_instance_profile = data.aws_iam_role.ssm_role.name
    tags = {
        Name = "Server-A"
    }
}

resource "aws_instance" "server_b" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.private_subnet_b
    vpc_security_group_ids = [var.sg_b]
    key_name = var.key_name
    iam_instance_profile = data.aws_iam_role.ssm_role.name
    tags = {
        Name = "Server-B"
    }
}

data "aws_iam_role" "ssm_role" {
    name = "SSM-for-ec2"
}

