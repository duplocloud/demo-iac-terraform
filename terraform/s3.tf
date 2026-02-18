# NEW CONTENT FOR s3.tf BASED ON PLAN
resource "aws_s3_bucket" "example" {
  bucket = "my-new-example-bucket"
  acl    = "private"
}