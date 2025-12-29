<h1 align="center">AWS Lambda Ansible</h1>

## Guide

This was a **proof-of-concept test** to see if Ansible could run inside AWS Lambda.

**Spoiler:** Lambda’s environment (no `/dev/shm`) prevents `ansible-playbook` from running properly, even with `--forks 1` or config tweaks.
