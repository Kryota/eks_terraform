output "public_subnet_ids" {
  description = "Public SubnetのID一覧"
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "Private SubnetのID一覧"
  value       = aws_subnet.private.*.id
}
