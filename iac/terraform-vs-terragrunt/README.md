<h1 align="center">Terraform vs Terragrunt</h1>

## Guide

- This is a comparison between Terraform Stacks vs Terragrunt.

- Problem Statement

    When deploying infrastructure across multiple Terraform modules (for example **VPC**, **subnets**, and **NAT layers**), plain Terraform makes it difficult to:

    - Change module boundaries without refactoring state
    - Flexibly enable/disable layers per environment
    - Orchestrate dependencies without tightly coupling modules
    - Reuse the same modules across environments with different compositions

## Usage
**Terragrunt**
- `cd terragrunt/prod`
- `terragrunt stack run init`
- `terragrunt stack run plan`
- `terragrunt stack run apply --non-interactive`

**Terraform**
- Terraform stacks are only available through HCP Terraform.

## Differences

| Feature            | Terraform Stacks                                                        | Terragrunt Stacks      |
| ------------------ | ----------------------------------------------------------------------- | ---------------------- |
| Execution          | HCP Terraform only                                                      | Local or CI            |
| State              | HCP-managed                                                             | Any Terraform backend  |
| File Type          | Component files: `.tfcomponent.hcl` & Deployment files: `.tfdeploy.hcl` | `terragrunt.stack.hcl` |
| Local `plan/apply` | ❌ No                                                                    | ✅ Yes                  |
| Flexibility        | Platform-centric                                                        | Environment-centric    |
| Cost               | SaaS-based                                                              | Free / OSS             |

## Results
If local execution and environment-level flexibility are required, Terragrunt Stacks provide a simpler and more adaptable workflow.
