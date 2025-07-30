data "archive_file" "ec2_start_zip" {
  type = "zip"
  source_file = "${path.module}/start-instance.py"
  output_path = "${path.module}/start-instance.zip"
}

data "archive_file" "ec2_stop_zip" {
  type = "zip"
  source_file = "${path.module}/stop-instance.py"
  output_path = "${path.module}/stop-instance.zip"
}

resource "aws_lambda_function" "start-instance" {
  filename = data.archive_file.ec2_start_zip.output_path
  function_name = var.start-function-name
  role = var.rolename
  handler = "start-instance.lambda_handler"
  source_code_hash = data.archive_file.ec2_start_zip.output_base64sha256
  runtime = "python3.12"

  environment {
    variables = {
      "Instance_id" = "${var.instance-id-lambda}"
      "region" = "${var.region}"
    }
  }
}

resource "aws_lambda_function" "stop-instance" {
  filename = data.archive_file.ec2_stop_zip.output_path
  function_name = var.stop-function-name
  role = var.rolename
  handler = "stop-instance.lambda_handler"
  source_code_hash = data.archive_file.ec2_stop_zip.output_base64sha256
  runtime = "python3.12"

  environment {
    variables = {
      "Instance_id" = "${var.instance-id-lambda}"
      "region" = "${var.region}"
    }
  }
}