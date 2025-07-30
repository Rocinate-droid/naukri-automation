resource "aws_scheduler_schedule" "start-schedule" {
  name = "start-schedule"

  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = "cron(30 12 * * ? *)"

  target {
    arn = var.lambda-start-arn
    role_arn = var.role-arn
  }
}

resource "aws_scheduler_schedule" "stop-schedule" {
  name = "stop-schedule"

  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = "cron(01 00 * * ? *)"

  target {
    arn = var.lambda-stop-arn
    role_arn = var.role-arn
  }
}