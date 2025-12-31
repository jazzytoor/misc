<h1 align="center">Argo CD Generators</h1>

## Overview

Problem statement: how do we automatically deploy applications to Argocd without any manual processes?

## Usage
- Ensure Docker Desktop is running with Kubernetes cluster enabled and Argocd is running on the cluster.
- `cd kubernetes/argocd/git-generator`.
- [syntax](./syntax.yaml) yaml file has been created to help define the sytax used.

### Git
- `kubectl apply -f git.yaml`.

### Pullrequests
- `kubectl apply -f pullrequest.yaml`.

**Future Scope**
- Can we update the version through GitHub Actions to the new image tag that been push to AWS ECR.
- What if we used `argocd-image-updater.argoproj.io` annotations to automatically pick up the new version.

## References
- [Argocd Generators](https://argo-cd.readthedocs.io/en/latest/operator-manual/applicationset/Generators/)
- [Try Argo CD locally](https://argo-cd.readthedocs.io/en/latest/try_argo_cd_locally/)
