terraform {
  backend "s3" {
    bucket       = "terraform-state-test-123-test"
    key          = "octopus/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
