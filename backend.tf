terraform {
  backend "s3" {
    bucket       = "mybucket-name-usecase-10"
    key          = "usecase10/statefile.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}


