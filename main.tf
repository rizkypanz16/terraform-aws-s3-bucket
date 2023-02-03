terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.49.0"
        }
    }
}

# mendefinisikan provider setting
provider "aws" {
    access_key = "<secret_key>"						# rubah <access_key> dengan aws api access_key milik anda
    secret_key = "<secret_key>"						# rubah <secret_key> dengan aws api secret_key milik anda
    region     = "us-east-1"						# rubah region dengan region yang anda inginkan
}

## General Configuration Amazon S3
resource "aws_s3_bucket" "panz16-s3-bucket" {
    bucket          = "panz16-s3-bucket"				  # name bucket
    force_destroy   = true                                # enable force destroy
    tags = {
        Name        = "panz16-s3-bucket"
        acl         = "public-access"
    }
}

## Block Public Access settings for this bucket
resource "aws_s3_bucket_public_access_block" "panz16-s3-bucket_publicaccess" {
  bucket = aws_s3_bucket.panz16-s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

## Bucket Versioning
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.panz16-s3-bucket.id

  versioning_configuration {
    status = "Enabled"                                  # value Enabled, Suspended, or Disabled
  }
}
