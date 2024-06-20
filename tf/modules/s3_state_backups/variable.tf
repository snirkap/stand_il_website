variable "s3_bucket_name" {
  type        = string
  description = "the name of the bucket"
  default     = "tf_remote_state_backups"
}