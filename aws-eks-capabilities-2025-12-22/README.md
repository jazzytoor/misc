<h1 align="center">AWS EKS Capabilities</h1>

## Guide

- AWS have announced [EKS capabilities](https://aws.amazon.com/blogs/aws/announcing-amazon-eks-capabilities-for-workload-orchestration-and-cloud-resource-management/) which include open Kubernetes solutions such as Argo CD.
- Infrastructure to deploy VPC, EKS, IAM Identity Centre User & Group and EKS capability.

## Usage
1. Ensure AWS CLI is configured.
2. `cd terraform` > `terraform init` > `terraform plan` > `terraform apply`.
3. Terraform outputs will display `server_url` where you can now access the Argo CD portal.
4. Login with the username and password from IAM Identity Centre.