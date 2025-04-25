# Terraform S3 Project

This project is a Terraform configuration for provisioning and managing an Amazon S3 bucket. It is designed to demonstrate infrastructure as code (IaC) principles and provide a reusable template for S3 bucket creation.

## Features

- Create an S3 bucket as static website, 
- The bucket will be the origin for cloudFront.
- Optional public access block configuration.
- Supports tagging for resource identification.

## Prerequisites

- AWS CLI installed and configured with appropriate credentials.
- An AWS account with permissions to create S3 buckets.

## Architecture Diagram

Below is the architecture diagram for the Terraform S3 Project:

![Terraform S3 Project Architecture](images/terraform-s3-diagram.png)

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/jdiaz2001/terraform-s3-project.git
    cd terraform-s3-project
    ```

2. Initialize the Terraform working directory:
    ```bash
    terraform init
    ```

3. Review and customize the variables in `variables.tf` or create a `terraform.tfvars` file to override defaults.

4. Plan the infrastructure changes:
    ```bash
    terraform plan
    ```

5. Apply the configuration to create the S3 bucket:
    ```bash
    terraform apply
    ```

6. Confirm the changes and note the output values.

## Configuration

The following variables can be customized:

| Variable           | Description                          | Default Value       |
|--------------------|--------------------------------------|---------------------|
| `bucket_name`      | Name of the S3 bucket               | `my-unique-bucket` |
| `region`           | AWS region for the bucket           | `us-east-1`        |
| `versioning`       | Enable versioning (true/false)      | `false`            |
| `encryption`       | Enable encryption (true/false)      | `true`             |
| `tags`             | Tags for the bucket                 | `{}`               |

## Outputs

- `bucket_id`: The ID of the created S3 bucket.
- `bucket_arn`: The ARN of the created S3 bucket.

## Cleanup

To destroy the resources created by this project, run:
```bash
terraform destroy
```
