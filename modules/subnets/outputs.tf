output "sg_a" {
    value = data.aws_security_group.sg_a.id
}

output "sg_b" {
    value = data.aws_security_group.sg_b.id
}

output "sg_c" {
    value = data.aws_security_group.sg_c.id
}

output "private_subnet_a" {
    value = aws_subnet.private_subnet_a.id
}

output "private_subnet_b" {
    value = aws_subnet.private_subnet_b.id
}

output "private_subnet_c" {
    value = aws_subnet.private_subnet_c.id
}

output "public_subnet_c" {
    value = aws_subnet.public_subnet_c.id
}
