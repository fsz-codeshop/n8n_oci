# Terraform Backend Configuration with OCI Object Storage

This directory contains Terraform configuration to deploy n8n on Oracle Cloud Infrastructure (OCI) with remote state storage in OCI Object Storage.

## Prerequisites

1. **OCI CLI Configuration**: Make sure you have OCI CLI configured with proper authentication
2. **Terraform**: Version 1.0 or later
3. **Required Variables**: Set the following environment variables:
   - `TF_VAR_tenancy_ocid`: Your OCI tenancy OCID
   - `TF_VAR_ssh_public_key`: Your SSH public key

## Setup Instructions

### Step 1: Initial Setup

1. Set your environment variables:
   ```bash
   export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..your-tenancy-ocid"
   export TF_VAR_ssh_public_key="ssh-rsa your-public-key-content"
   ```

2. Run the setup script to create the bucket and configure the backend:
   ```bash
   cd terraform
   ./setup_backend.sh
   ```

### Step 2: Use Remote State

After the bucket is created, you can use remote state storage:

1. Copy the generated backend configuration:
   ```bash
   cp backend_configured.tf backend.tf
   ```

2. Initialize Terraform with the new backend:
   ```bash
   terraform init -migrate-state
   ```

3. Apply your configuration:
   ```bash
   terraform apply
   ```

## Manual Backend Configuration

If you prefer to configure the backend manually:

1. Create the bucket first:
   ```bash
   terraform init
   terraform apply -target=oci_objectstorage_bucket.terraform_state
   ```

2. Get the bucket information:
   ```bash
   terraform output terraform_state_bucket_name
   terraform output terraform_state_bucket_namespace
   ```

3. Update `backend.tf` with your actual values:
   ```hcl
   terraform {
     backend "http" {
       address = "https://objectstorage.YOUR-REGION.oraclecloud.com/b/YOUR-BUCKET-NAME/o/terraform.tfstate"
       lock_address = "https://objectstorage.YOUR-REGION.oraclecloud.com/b/YOUR-BUCKET-NAME/o/terraform.tfstate-lock"
       unlock_address = "https://objectstorage.YOUR-REGION.oraclecloud.com/b/YOUR-BUCKET-NAME/o/terraform.tfstate-lock"
     }
   }
   ```

4. Initialize with the new backend:
   ```bash
   terraform init -migrate-state
   ```

## Backend Configuration Details

The backend uses OCI Object Storage with the following features:

- **Versioning**: Enabled for state file history
- **Access Control**: No public access
- **Locking**: Uses HTTP backend with lock files
- **Encryption**: Can be configured with OCI KMS keys

## Security Considerations

1. **Access Control**: The bucket is configured with `NoPublicAccess` to prevent unauthorized access
2. **Versioning**: Enabled to maintain state file history
3. **Authentication**: Requires proper OCI authentication (API key, config file, etc.)
4. **Encryption**: Can be enhanced with OCI KMS encryption

## Troubleshooting

### Common Issues

1. **Authentication Errors**: Ensure your OCI CLI is properly configured
2. **Bucket Creation Fails**: Check your tenancy OCID and permissions
3. **Backend Migration Fails**: Ensure you have the correct bucket URL and permissions

### Useful Commands

- Check bucket status: `oci os bucket get --bucket-name YOUR-BUCKET-NAME`
- List objects in bucket: `oci os object list --bucket-name YOUR-BUCKET-NAME`
- View state file: `terraform show`

## Files Overview

- `main.tf`: Main Terraform configuration for n8n infrastructure
- `bucket.tf`: Bucket resources and outputs for Terraform state storage
- `variables.tf`: Variable definitions including bucket configuration
- `backend.tf`: Backend configuration template
- `setup_backend.sh`: Automated setup script
- `README_BACKEND.md`: This documentation file 