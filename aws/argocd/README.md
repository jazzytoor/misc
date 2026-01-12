# AWS EKS Argo CD

## Overview
This project deploys Argo CD on an AWS EKS cluster to provide a GitOps continuous delivery platform for Kubernetes applications. 

The deployment includes:
- EKS cluster managed via Terraform
- Argo CD installed using the official Helm chart
- External access through an AWS Application Load Balancer (ALB) with a public DNS hostname managed in Route 53
- TLS termination at the ALB using AWS ACM certificates
- Authentication and Single Sign-On (SSO) integrated with AWS IAM Identity Center (formerly AWS SSO) for secure user access

## Usage
1. `cd aws/argocd/terraform`
2. Create `variables.auto.tfvars` file and input the following variables
    ```bash
    region = "enter aws region"
    service = "argocd"
    domain  = "enter in the route53 domain"
    ```
3. `terraform init` > `terraform plan` > `terraform apply -auto-approve`