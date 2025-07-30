output "public-ip" {
  value = ["${aws_instance.s3-instance.*.public_ip}"]
}

output "instance-id" {
  value = aws_instance.s3-instance.id
}