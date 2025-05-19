terraform {
  backend "s3" {
    bucket = "eks-blueprint-gitops"
    key = "tf-statelock/gitops-bridge/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}