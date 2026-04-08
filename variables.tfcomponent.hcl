variable "region" {
  description = "AWS region for the shared EKS cluster."
  type        = string
  default     = "us-east-2"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key."
  type        = string
  ephemeral   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key."
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "AWS_SESSION_TOKEN" {
  description = "AWS session token."
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "kube_namespace" {
  description = "Kubernetes namespace where the demo app is deployed."
  type        = string
}

variable "kube_cluster_endpoint" {
  description = "EKS control plane endpoint from the k8s stack."
  type        = string
}

variable "kube_cluster_certificate_authority_data" {
  description = "Base64-encoded EKS cluster CA bundle published by the k8s stack."
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name or ID derived from the k8s stack for local auth."
  type        = string
}

variable "ldap_mount_path" {
  description = "Vault LDAP secrets engine mount path from the vault stack."
  type        = string
}

variable "vso_vault_auth_name" {
  description = "VaultAuth resource name consumed by VSO."
  type        = string
}

variable "static_role_rotation_period" {
  description = "LDAP static role rotation period in seconds from the vault stack."
  type        = number
}

variable "ldap_dual_account" {
  description = "Whether the vault stack enabled dual-account LDAP rotation."
  type        = bool
}

variable "grace_period" {
  description = "Dual-account grace period in seconds from the vault stack."
  type        = number
}

variable "vault_app_auth_role" {
  description = "Vault Kubernetes auth role used by the app for direct Vault polling."
  type        = string
  default     = ""
}

variable "vault_agent_auth_role_name" {
  description = "Vault Kubernetes auth role for the Vault Agent demo variant."
  type        = string
  default     = "vault-agent-app-role"
}

variable "vault_agent_static_role_name" {
  description = "Vault LDAP static role used by the Vault Agent demo variant."
  type        = string
  default     = "vault-agent-dual-role"
}

variable "csi_auth_role_name" {
  description = "Vault Kubernetes auth role for the CSI demo variant."
  type        = string
  default     = "csi-app-role"
}

variable "csi_static_role_name" {
  description = "Vault LDAP static role used by the CSI demo variant."
  type        = string
  default     = "csi-dual-role"
}

variable "ldap_app_image" {
  description = "Docker image for the LDAP credentials display application."
  type        = string
  default     = "ghcr.io/andybaran/vault-ldap-demo:latest"
}

variable "ldap_app_account_name" {
  description = "AD service account name to display in the LDAP app when single-account mode is used."
  type        = string
  default     = "svc-rotate-a"
}
