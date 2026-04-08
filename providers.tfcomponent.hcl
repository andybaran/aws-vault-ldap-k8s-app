required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "6.27.0"
  }
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "3.0.1"
  }
}

provider "aws" "this" {
  config {
    region     = var.region
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
    token      = var.AWS_SESSION_TOKEN
  }
}

provider "kubernetes" "this" {
  config {
    host                   = var.kube_cluster_endpoint
    cluster_ca_certificate = base64decode(var.kube_cluster_certificate_authority_data)
    token                  = component.eks_auth.token
  }
}
