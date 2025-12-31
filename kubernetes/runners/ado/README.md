<h1 align="center">Azure Pipelines Ado Agent Keda Scaler</h1>

## Overview

- `deployment.yaml` is required to deploy agent that is online but inactive so that pipelines can still continue to run jobs otherwise you will get the following error: `##[error]No agents were found in pool xxx. Configure an agent for the pool and try again.`.
- `scaledjob.yaml` will then be allowed to listen on any jobs and spin up the required agent.
- `--once` is required in the shell script so that the agent will terminate and cleanup itself when the job is completed.

## Usage
1. Generate PAT token from Azure DevOps providing `Agent Pools: Read & manage` scope.
2. `cd kubernetes/runners/ado`.
3. To build the Dockerfile you can run the following command: `docker build -t ado:latest docker`.
4. Deploy the Kubernetes manifest by `kubectl apply -f agent`.

## Future Scope
- Deploy solution to AWS EKS and provide scaled agents.
- Use of Karpenter to deploy backend compute resources (ec2).

## References
- [Azure Pipelines Keda](https://keda.sh/docs/2.18/scalers/azure-pipelines/)
- [Azure DevOps Agent](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#linux)
