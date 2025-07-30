data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "s3-read-policy-doc" {
  statement {
			sid = "Statement1"
			effect = "Allow"
			actions = [
				"s3:ListBucket",
				"s3:GetObject"
			]
			resources = [
                "arn:aws:s3:::${var.bucket-name}",
                "arn:aws:s3:::${var.bucket-name}/*"
			    ]
		}
}

data "aws_iam_policy_document" "lambda-start-stop-ec2" {
  statement {
    sid = "Statement1"
    effect = "Allow"
    actions = [
       "ec2:DescribeInstances",
       "ec2:StartInstances",
       "ec2:StopInstances"
    ]
    resources = [
      "arn:aws:ec2:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:instance/${var.instance-id}"
    ]
  }
}

data "aws_iam_policy_document" "lambda-eventwatch" {
  statement {
    sid = "Statement1"
    effect = "Allow"
    actions = [
       "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:function:${var.start-function-name-ec2}",
      "arn:aws:lambda:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:function:${var.stop-function-name-ec2}"
    ]
  }
}

data "aws_iam_policy_document" "eventwatchAssumeRole" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "scheduler.amazonaws.com" ]
    }
  }
}

data "aws_iam_policy_document" "LambdaAssumeRole" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "lambda.amazonaws.com" ]
    }
  }
}

data "aws_iam_policy_document" "ec2AssumeRole" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "s3-read-policy" {
  name = "s3-read-policy"
  policy = data.aws_iam_policy_document.s3-read-policy-doc.json
}

resource "aws_iam_policy" "lambda-ec2-start-stop" {
  name = "lambda-start-stop-ec2"
  policy = data.aws_iam_policy_document.lambda-start-stop-ec2.json
}

resource "aws_iam_policy" "eventwatch-instance" {
  name = "eventwach-instance"
  policy = data.aws_iam_policy_document.lambda-eventwatch.json
}

resource "aws_iam_role" "s3-read-role" {
  name = "s3Role"
  assume_role_policy = data.aws_iam_policy_document.ec2AssumeRole.json
}

resource "aws_iam_role" "lambda-role" {
  name = "lambdarole"
  assume_role_policy = data.aws_iam_policy_document.LambdaAssumeRole.json
}

resource "aws_iam_role" "eventwatch-role-ec2" {
  name = "eventwatch-role-ec2"
  assume_role_policy = data.aws_iam_policy_document.eventwatchAssumeRole.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "attachement-for-s3" {
  role = aws_iam_role.s3-read-role.name
  policy_arn = aws_iam_policy.s3-read-policy.arn
}

resource "aws_iam_role_policy_attachment" "attachement-for-lambda" {
  role = aws_iam_role.lambda-role.name
  policy_arn = aws_iam_policy.lambda-ec2-start-stop.arn
}

resource "aws_iam_role_policy_attachment" "attachement-for-eventwatch" {
  role = aws_iam_role.eventwatch-role-ec2.name
  policy_arn = aws_iam_policy.eventwatch-instance.arn
}

resource "aws_iam_instance_profile" "s3-read-profile" {
  name = "s3-read-profile"
  role = aws_iam_role.s3-read-role.name
}

