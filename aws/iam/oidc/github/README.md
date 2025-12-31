<h1 align="center">GitHub OpenID Connect AWS</h1>

## Overview

Instead of using AWS Iam User for authenication accessing AWS services through GitHub we can use OpenID Connect instead.

## Usage
1. `cd aws/iam/oidc/github/terraform`
2. Create `variables.auto.tfvars` file and input the following variables
    ```bash
    region = "enter aws region"
    ```
3. `terraform init` > `terraform plan` > `terraform apply -auto-approve`
4. In your GitHub actions `.yml` file you can use the following step:
    ```yaml
    - name: Configure AWS Credentials
      uses: aws-actions/configure-aws-credentials@v5.1.1
      with:
        aws-region: <REGION>>
        role-to-assume: arn:aws:iam::<AWS_ACCOUNT_ID>:role/github-actions
        role-session-name: aws
    ```
5. Ensure to set the following permissions either at job or workflow level
    ```yaml
    permissions:
      id-token: write
      contents: read
    ```