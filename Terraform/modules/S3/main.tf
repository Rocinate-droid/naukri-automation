resource "aws_s3_bucket" "resume-bucket" {
  bucket = var.bucketname

  tags = {
    Name = "resume-bucket"
  }
}

resource "aws_s3_object" "s3-object" {
  bucket = aws_s3_bucket.resume-bucket.bucket
  key = var.keyname
  source = var.sourceoffile
  etag = filemd5(var.sourceoffile)
  content_type = "application/pdf"

  tags = {
    Name = "resume-object"
  }
}

resource "aws_s3_bucket_versioning" "resume-bucket-versioning" {
  bucket = aws_s3_bucket.resume-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}