<h1 align="center">GitHub AWS ECR</h1>

## Guide

- Service showcasing how to Docker build, tag, and push docker image to Amazon ECR.
- Terraform infrastructure is also provided.
- Ensure AWS CLI is installed and configured to your AWS account.

## Usage
**Infrastructure**
- `cd cicd/github/ecr/terraform`
- `terraform init`
- `terraform plan`
- `terraform apply -auto-approve`

- IAM user will be created with ECR permissions to allow you to tag and push to AWS ECR.
  - Run the following command to get the access key and secret key:
    - `terraform output iam_user_access_key_id`
    - `terraform output iam_user_access_key_secret`
    - Within the settings of the repository > secrets > actions > create the following secret:
      - AWS_ACCESS_KEY_ID (iam_user_access_key_id)
      - AWS_SECRET_ACCESS_KEY (iam_user_access_key_secret)
      - AWS_REGION
