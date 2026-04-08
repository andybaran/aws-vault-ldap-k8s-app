---
applyTo: "*.tf,*.hcl,*.md"
---

# Project: aws-vault-ldap-k8s-app

## Goal

Own the demo application slice of the Terraform Cloud Stacks refactor. The overall demo still shows Vault rotating AD credentials for an app on EKS, and this repo should keep that end-user workload focused, readable, and separate from platform or Vault internals.

## Scope

- application deployment resources and app-facing Kubernetes configuration
- consumption of Vault secret-delivery contracts
- documentation for the app stack's linked-stack inputs and outputs

## Guardrails

- Keep using Terraform Stacks root files and explicit linked-stack contracts.
- Keep this repo limited to the app layer. Do not move platform, AD, or Vault ownership here.
- Model dependencies on the k8s and vault repos clearly in variables, outputs, and README text.
- Preserve the demo goal: show rotated AD credentials reaching a running app on Kubernetes.
- When the app contract changes, update README and output descriptions in the same change.
