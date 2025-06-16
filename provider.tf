terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.99.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.17.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  region = "us-east-1"
}

# Configure Kubernetes provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "/aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

# Configure Helm provider
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

