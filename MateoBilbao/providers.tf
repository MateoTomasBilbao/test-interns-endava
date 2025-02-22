provider "aws" {
}

resource "aws_s3_bucket" "TextBucket" {
  bucket = "text-bucket-mateo"

  tags = {
    Name = "Text Bucket Mateo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "TextBucketACLPerms" {
  bucket = aws_s3_bucket.TextBucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "TextBucketACL" {
    depends_on = [ aws_s3_bucket_ownership_controls.TextBucketACLPerms ]
    
    bucket = aws_s3_bucket.TextBucket.id
    acl = "private"
}

resource "aws_s3_object" "Text" {

  bucket = aws_s3_bucket.TextBucket.id
  key = "text.txt"
  content = "Hello World."
}

provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "script.py"
  output_path = "script.zip"
}