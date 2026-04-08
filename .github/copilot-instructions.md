---
applyTo: "*.tf,*.hcl,*.md"
---

# Project: aws-vault-ldap-k8s-app

## Goal

Own the demo application slice of the Terraform Cloud Stacks refactor. This repo deploys the LDAP demo app onto EKS, consumes Vault-linked LDAP delivery contracts, and stays focused on the workload layer rather than platform or Vault internals.

## Scope

- application deployment resources and app-facing Kubernetes configuration
- consumption of linked-stack outputs from the k8s and vault stacks
- local derivation of EKS auth data from the AWS provider for Kubernetes access
- documentation for the app stack's linked-stack contract and useful outputs

## Linked-stack contract

Expected upstream stack sources:

- `app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-k8s`
- `app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-vault`

Expected upstream outputs from the k8s stack:

- `cluster_endpoint`
- `cluster_ca_data`
- `cluster_name` or `cluster_id`
- `kube_namespace`
- `region`

Expected upstream outputs from the vault stack:

- `ldap_secrets_mount_path`
- `vso_vault_auth_name`
- `vault_app_auth_role_name`
- `ldap_dual_account`
- `grace_period`
- `static_role_rotation_period`
- optionally `vault_agent_auth_role_name`
- optionally `vault_agent_static_role_name`
- optionally `csi_auth_role_name`
- optionally `csi_static_role_name`

## Guardrails

- Keep using Terraform Stacks root files and explicit `upstream_input` blocks.
- Keep this repo limited to the app layer. Do not move platform, AD, Vault, or Python image pipeline ownership here.
- Preserve the source demo defaults for the app image and default LDAP account unless there is a repo-specific reason to change them.
- Derive the EKS auth token locally via AWS instead of depending on a published upstream token.
- Publish linked-stack outputs only if they become genuinely useful; this stack has no required downstream dependencies today.
- When the app contract changes, update README and these instructions in the same change.
