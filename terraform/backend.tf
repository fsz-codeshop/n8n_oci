# Backend configuration for OCI Object Storage
# This file was automatically generated by setup_backend.sh
# 
# Bucket: terraform-state
# Namespace: gryydpwcqj5q
# Region: sa-saopaulo-1

terraform {
  backend "oci" {
    bucket = "terraform-state"
    namespace = "gryydpwcqj5q"
    region = "sa-saopaulo-1"
    key = "terraform.tfstate"
  }
}
