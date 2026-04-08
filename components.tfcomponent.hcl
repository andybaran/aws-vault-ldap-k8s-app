locals {
  ldap_static_role_name = var.ldap_dual_account ? "dual-rotation-demo" : var.ldap_app_account_name
}

# Derive the EKS auth token locally so this stack does not depend on an upstream token output.
component "eks_auth" {
  source = "./modules/eks_auth"

  inputs = {
    cluster_name = var.eks_cluster_name
  }

  providers = {
    aws = provider.aws.this
  }
}

component "ldap_app" {
  source = "./modules/ldap_app"

  inputs = {
    kube_namespace               = var.kube_namespace
    ldap_mount_path              = var.ldap_mount_path
    ldap_static_role_name        = local.ldap_static_role_name
    vso_vault_auth_name          = var.vso_vault_auth_name
    static_role_rotation_period  = var.static_role_rotation_period
    ldap_app_image               = var.ldap_app_image
    ldap_dual_account            = var.ldap_dual_account
    grace_period                 = var.grace_period
    vault_app_auth_role          = var.vault_app_auth_role
    vault_agent_auth_role_name   = var.vault_agent_auth_role_name
    vault_agent_static_role_name = var.vault_agent_static_role_name
    csi_auth_role_name           = var.csi_auth_role_name
    csi_static_role_name         = var.csi_static_role_name
  }

  providers = {
    kubernetes = provider.kubernetes.this
  }
}
