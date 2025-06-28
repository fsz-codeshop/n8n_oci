variable "tenancy_ocid" {
  description = "OCID of Oracle Cloud Tenancy"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaa3p6sersiimd5q45we7f6tvei6hwfq2kc4mgmxcrs5mqxj6khhgbq"
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCe6NPzSJ2mOL6NY38HLv8k1Pc51s6JNeTns/YHqVNF0IE22TpaG5CPFpnqPSsUYZMgmxHQErSqo+vxnM0eBUkm4KCJrQ6GjdxL3p0vj7z6QP8dKbBwT5UoogZ1jw4ujuC21EjJfZrqbSKqvr5rdiKWuHJl869P/xdVS5G3pT72F5eW7X/2eIig7WkTf30doKt22xdFkIElfskIa3icQg/wuM5hBvoKfmzsTzcQQk4TIg/NVWeTASmzJWRne6SduwdZrC5QnCbRHHIhFeEwgJZTPInVdjAHpWWmRA+r/mfxvDf270ave7yPgIfWnEoBA68433FdBsvMxBrnKZPycu7P n8n-hetzner-rsa-key-20250605"
}

variable "oci_region" {
  description = "OCI region"
  type        = string
  default     = "sa-saopaulo-1"
}

variable "bucket_name" {
  description = "Name of the OCI bucket to store Terraform state"
  type        = string
  default     = "terraform-state"
}

variable "bucket_namespace" {
  description = "OCI Object Storage namespace"
  type        = string
  default     = ""
}
