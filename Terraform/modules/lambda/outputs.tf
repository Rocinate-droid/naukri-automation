output "start-lambda-arn" {
  value = aws_lambda_function.start-instance.arn
}

output "stop-lambda-arn" {
  value = aws_lambda_function.stop-instance.arn
}