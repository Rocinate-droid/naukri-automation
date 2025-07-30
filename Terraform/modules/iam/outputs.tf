output "instane-profile" {
  value = aws_iam_instance_profile.s3-read-profile.name
}

output "lambda-iam-rolearn" {
  value = aws_iam_role.lambda-role.arn
}

output "eventwatch-role-arn" {
  value = aws_iam_role.eventwatch-role-ec2.arn
}

