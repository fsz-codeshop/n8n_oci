# Get the namespace for the bucket
data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.tenancy_ocid
}

# Get home region for bucket URL
data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid
  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# Create bucket for Terraform state
resource "oci_objectstorage_bucket" "terraform_state" {
  compartment_id = var.tenancy_ocid
  name           = var.bucket_name
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = "NoPublicAccess"
  versioning     = "Enabled"

  # Optional: Add encryption
  kms_key_id = null

  # Optional: Add object lifecycle policy
  object_events_enabled = false
}

# Outputs for bucket information
output "terraform_state_bucket_name" {
  description = "Name of the bucket storing Terraform state"
  value       = oci_objectstorage_bucket.terraform_state.name
}

output "terraform_state_bucket_namespace" {
  description = "Namespace of the bucket storing Terraform state"
  value       = oci_objectstorage_bucket.terraform_state.namespace
}

output "terraform_state_bucket_url" {
  description = "URL for the Terraform state file in OCI Object Storage"
  value       = "https://objectstorage.${var.oci_region}.oraclecloud.com/b/${oci_objectstorage_bucket.terraform_state.name}/o/terraform.tfstate"
}
