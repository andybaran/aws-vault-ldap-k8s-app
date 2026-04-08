# aws-vault-ldap-k8s-app

Terraform Cloud Stacks scaffold for the application slice of the `aws-vault-ldap-k8s` demo.

This repository is intended to own the demo workload that proves the end-to-end flow: Vault rotates Active Directory credentials and the application receives them on Kubernetes. It should stay focused on the app deployment and app-facing secret-delivery integration points.

## Stack purpose

- deploy the demo application workload on the shared Kubernetes platform
- consume Vault-delivered LDAP credential contracts from the Vault stack
- publish app access metadata and smoke-test outputs when useful

## Upstream linked-stack contract

Current scaffold assumption: this stack will consume linked-stack outputs from both `aws-vault-ldap-k8s-k8s` and `aws-vault-ldap-k8s-vault`.

Planned upstream inputs from `aws-vault-ldap-k8s-k8s`:

- Kubernetes namespace, ingress, and general workload placement metadata
- cluster-level details needed for app deployment resources

Planned upstream inputs from `aws-vault-ldap-k8s-vault`:

- Vault auth role and connection metadata
- LDAP secrets engine mount path and role names
- delivery-mode-specific secret reference metadata

## Downstream linked-stack contract

This stack is not expected to be a required upstream for another stack. It may still publish useful outputs such as:

- service names and ingress/load balancer URLs
- health endpoint or smoke-test metadata
- app mode details that help validate the demo end to end

## Terraform Cloud Stacks

This repo is scaffolded around Terraform Stacks root files:

- `components.tfcomponent.hcl`
- `providers.tfcomponent.hcl`
- `variables.tfcomponent.hcl`
- `deployments.tfdeploy.hcl`

The HCL files are placeholders only. Later todos should add the actual application components and linked-stack wiring.
