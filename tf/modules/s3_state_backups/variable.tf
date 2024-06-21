variable "s3_bucket_name" {
  type        = string
  description = "the name of the bucket"
  default     = "tf-remote-state-backups-stand-il"
}