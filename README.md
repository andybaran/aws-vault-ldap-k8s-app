# aws-vault-ldap-k8s-app

Terraform Cloud Stacks repo for the application slice of the `aws-vault-ldap-k8s` demo.

This repository owns the Kubernetes workload that proves the end-to-end flow: Vault rotates Active Directory credentials and the demo application receives them on EKS. It intentionally does not own the Python image build or image pipeline; the application image continues to come from the source repository.

## Stack purpose

- deploy the demo LDAP application workload onto the shared EKS platform
- consume Vault-linked LDAP delivery metadata from the Vault stack
- derive EKS authentication locally from AWS instead of depending on a published upstream auth token
- expose useful human-facing app outputs such as service names and URLs

## Repository layout

- `modules/ldap_app` - copied from the source repo and kept focused on app-facing Kubernetes resources
- `modules/eks_auth` - small helper module that derives an EKS auth token via the AWS provider
- `components.tfcomponent.hcl` - component graph and split-repo app wiring
- `providers.tfcomponent.hcl` - AWS and Kubernetes provider configuration for the stack
- `variables.tfcomponent.hcl` - deployment inputs for app, EKS, Vault, and AWS credentials
- `outputs.tfcomponent.hcl` - useful app deployment outputs
- `deployments.tfdeploy.hcl` - linked-stack dependencies, shared varset usage, and the demo deployment

## Upstream linked-stack contract

This stack depends on the following Terraform Cloud Stacks:

- `app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-k8s`
- `app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-vault`

Expected inputs from the k8s stack:

- `cluster_endpoint`
- `cluster_ca_data`
- `cluster_name` (with `cluster_id` also available if needed)
- `kube_namespace`
- `region`

Expected inputs from the vault stack:

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

## Demo defaults preserved from the source repo

- `ldap_app_image = ghcr.io/andybaran/vault-ldap-demo:latest`
- `ldap_app_account_name = svc-rotate-a`
- `ldap_static_role_name = dual-rotation-demo` when dual-account mode is enabled; otherwise it uses `ldap_app_account_name`
- `ldap_dual_account`, `grace_period`, and `static_role_rotation_period` are consumed from the Vault stack
- Vault Agent and CSI role names fall back to the source demo defaults until the Vault stack publishes explicit outputs for them

The development deployment uses the shared AWS credentials varset `varset-oUu39eyQUoDbmxE1`.

## Downstream contract

This stack has no required downstream linked-stack consumers. It keeps regular stack outputs for operators, but it does not publish linked-stack outputs by default.

## Local validation

```bash
terraform stacks fmt
terraform stacks init
terraform stacks validate
```
