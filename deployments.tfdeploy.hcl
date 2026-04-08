store varset "aws_creds" {
  id       = "varset-oUu39eyQUoDbmxE1"
  category = "env"
}

upstream_input "k8s_stack" {
  type   = "stack"
  source = "app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-k8s"
}

upstream_input "vault_stack" {
  type   = "stack"
  source = "app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-vault"
}

deployment "development" {
  inputs = {
    region = upstream_input.k8s_stack.region

    kube_namespace                          = upstream_input.k8s_stack.kube_namespace
    kube_cluster_endpoint                   = upstream_input.k8s_stack.cluster_endpoint
    kube_cluster_certificate_authority_data = upstream_input.k8s_stack.cluster_ca_data
    eks_cluster_name                        = try(upstream_input.k8s_stack.cluster_name, upstream_input.k8s_stack.cluster_id)

    ldap_mount_path              = try(upstream_input.vault_stack.ldap_secrets_mount_path, "ldap")
    vso_vault_auth_name          = try(upstream_input.vault_stack.vso_vault_auth_name, "default")
    static_role_rotation_period  = upstream_input.vault_stack.static_role_rotation_period
    ldap_dual_account            = upstream_input.vault_stack.ldap_dual_account
    grace_period                 = upstream_input.vault_stack.grace_period
    vault_app_auth_role          = try(upstream_input.vault_stack.vault_app_auth_role_name, "")
    vault_agent_auth_role_name   = try(upstream_input.vault_stack.vault_agent_auth_role_name, "vault-agent-app-role")
    vault_agent_static_role_name = try(upstream_input.vault_stack.vault_agent_static_role_name, "vault-agent-dual-role")
    csi_auth_role_name           = try(upstream_input.vault_stack.csi_auth_role_name, "csi-app-role")
    csi_static_role_name         = try(upstream_input.vault_stack.csi_static_role_name, "csi-dual-role")

    ldap_app_image        = "ghcr.io/andybaran/vault-ldap-demo:latest"
    ldap_app_account_name = "svc-rotate-a"

    AWS_ACCESS_KEY_ID     = store.varset.aws_creds.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = store.varset.aws_creds.AWS_SECRET_ACCESS_KEY
    AWS_SESSION_TOKEN     = store.varset.aws_creds.AWS_SESSION_TOKEN
  }
}
