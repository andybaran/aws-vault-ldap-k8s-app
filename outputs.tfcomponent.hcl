output "ldap_static_role_name" {
  description = "LDAP static role name used by the application deployment."
  type        = string
  value       = local.ldap_static_role_name
}

output "ldap_app_service_name" {
  description = "Kubernetes service name for the default LDAP demo app."
  type        = string
  value       = component.ldap_app.ldap_app_service_name
}

output "ldap_app_url" {
  description = "Load balancer URL for the default VSO-backed LDAP demo app."
  type        = string
  value       = component.ldap_app.ldap_app_url
}

output "ldap_app_vault_agent_url" {
  description = "Load balancer URL for the Vault Agent sidecar demo app."
  type        = string
  value       = component.ldap_app.ldap_app_vault_agent_url
}

output "ldap_app_csi_url" {
  description = "Load balancer URL for the CSI-backed demo app."
  type        = string
  value       = component.ldap_app.ldap_app_csi_url
}
