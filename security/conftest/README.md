<h1 align="center">Conftest</h1>

## Guide

This repository contains **Conftest policies** for linting Dockerfiles.

The policies help enforce best practices and security rules, including:

- Disallowing `ADD` commands (use `COPY` instead)
- Restricting `FROM` images and tags (no `latest`, only allowed base images)
- Enforcing explicit non-root `USER` instructions

These rules can help catch common mistakes and improve container security.

## Usage

- Install Conftest
    ```bash
    brew install conftest   # macOS
    choco install conftest  # Windows
    curl -sL https://github.com/open-policy-agent/conftest/releases/download/v0.40.0/conftest_0.40.0_Linux_x86_64.tar.gz | tar xz
    ```

- `conftest test Dockerfile` to run a test against file of choice.
- `conftest verify` to run the unit tests.
