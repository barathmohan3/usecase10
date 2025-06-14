output "ec2_id" {
value = aws_instance.focal_ec2.id
}
 
output "security_group_id" {
value = aws_security_group.focal_sg.id
}