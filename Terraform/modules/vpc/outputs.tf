output "vpc-id" {
  value = aws_vpc.s3-vpc.id
}

output "subnet-id" {
  value = aws_subnet.s3-subnet.id
}