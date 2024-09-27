#Instance A
output "instance_A" {
  description = "ID of the EC2 instance"
  value       = aws_instance.instance_A.id
}

output "instance_public_ip_A" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.instance_A.public_ip
}

#Instance B
output "instance_B" {
  description = "ID of the EC2 instance"
  value       = aws_instance.instance_B.id
}

output "instance_public_ip_B" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.instance_B.public_ip
}