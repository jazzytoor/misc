<h1 align="center">Welcome to GitHub Runner Scaler 👋</h1>

## ✨ Guide

- 🚀 How to encode token? `echo -n "TOKEN" | base64`
- 🚀 How to install CRD? `kubectl apply -f https://github.com/kedacore/keda/releases/download/v{version}/keda-{version}.yaml`

## Troubleshoot

- ❗️ You may get something like `The CustomResourceDefinition "scaledjobs.keda.sh" is invalid: metadata.annotations: Too long: must have at most 262144 bytes` when installing the CRD, may need to add `--server-side` to `kubectl command`