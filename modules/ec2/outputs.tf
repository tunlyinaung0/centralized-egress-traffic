output "server_a_private_ip" {
    value = aws_instance.server_a.private_ip
}

output "server_b_private_ip" {
    value = aws_instance.server_b.private_ip
}