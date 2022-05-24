output "bucketA_arn" {
  value = module.s3Bucket.source_bucket_arn
}

output "bucketB_arn" {
  value = module.s3Bucket.destination_bucket_arn
}