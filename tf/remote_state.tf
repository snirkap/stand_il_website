terraform {
  backend "s3" {
    bucket = "tf-remote-state-backups-stand-il"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}