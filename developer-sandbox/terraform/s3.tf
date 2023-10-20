data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  bucket = "developer-sandbox-${data.aws_caller_identity.current.account_id}"
  tags = { "source" = "aft"}

}

resource "aws_s3_bucket_ownership_controls" "sandbox_bucket" {
  bucket = aws_s3_bucket.sandbox_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "sandbox_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.sandbox_bucket]

  bucket = aws_s3_bucket.sandbox_bucket.id
  acl    = "private"
}