###############################################################################
# General Cluster Configuration
###############################################################################

variable "name" {
  description = "Stack name"
  type        = string
  default     = "eks-gitops-bridge"
}

variable "environment" {
  description = "environment"
  type        = string
  default     = "prod"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "cluster_endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Whether to enable cluster creator admin permissions"
  type        = bool
  default     = true
}

###############################################################################
# Network Configuration
###############################################################################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "availability_zones_count" {
  description = "Number of Availability Zones to use"
  type        = number
  default     = 2
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for VPC"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use single NAT Gateway for all private subnets"
  type        = bool
  default     = true
}

###############################################################################
# DNS and Domain Configuration
###############################################################################

variable "domain_name" {
  description = "Route 53 domain name"
  type        = string
  default     = "pocketfm.org"
}

variable "aws_route53_zone_arn" {
  description = "Route 53 Hosted Zone Domain arn"
  type        = string
  default     = "arn:aws:route53:::hostedzone/Z02615673MV0V4C7812FD"
}

variable "is_route53_private_zone" {
  description = "Whether Route53 zone is private"
  type        = bool
  default     = false
}

variable "route53_record_ttl" {
  description = "TTL for Route53 records"
  type        = number
  default     = 60
}

variable "route53_allow_overwrite" {
  description = "Allow overwrite of Route53 records"
  type        = bool
  default     = true
}

###############################################################################
# ArgoCD Configuration
###############################################################################

variable "argocd_subdomain" {
  description = "Subdomain for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "argo_workflows_subdomain" {
  description = "Subdomain for Argo Workflows"
  type        = string
  default     = "argoworkflows"
}

variable "argocd_chart_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "8.0.4"
}

variable "argocd_repository" {
  description = "Repository URL for ArgoCD Helm chart"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_namespace" {
  description = "Kubernetes namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "argocd_force_update" {
  description = "Whether to force update ArgoCD"
  type        = bool
  default     = true
}

variable "ssh_key_path" {
  description = "SSH key path for git access"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

###############################################################################
# Kubernetes Addons Configuration
###############################################################################

variable "addons" {
  description = "Kubernetes addons"
  type        = any
  default = {
    enable_argocd                      = false
    enable_aws_argocd_ingress          = true
    enable_argo_workflows              = false # set to false if enable_aws_argo_workflows_ingress = true
    enable_aws_argo_workflows_ingress  = true  # set to true if enable_argo_workflows is false
    enable_cert_manager                = true
    enable_argo_events                 = true
    enable_external_dns                = true  # set to true if enable_aws_argo_workflows_ingress = true
    enable_aws_load_balancer_controller = true
    enable_aws_ebs_csi_resources       = true  # generate gp2 and gp3 storage classes for ebs-csi
    enable_external_secrets            = true
    enable_karpenter                   = true
    
    # Commented out addons - uncomment as needed
    # enable_aws_efs_csi_driver         = true
    # enable_aws_fsx_csi_driver         = true
    # enable_aws_cloudwatch_metrics     = true
    # enable_aws_privateca_issuer       = true
    # enable_cluster_autoscaler         = true
    # enable_aws_for_fluentbit          = true
    # enable_aws_node_termination_handler = true
    # enable_velero                     = true
    # enable_aws_gateway_api_controller = true
    # enable_aws_secrets_store_csi_driver_provider = true
    # enable_argo_rollouts              = true
    # enable_gpu_operator               = true
    # enable_kube_prometheus_stack      = true
    # enable_metrics_server             = true
    # enable_prometheus_adapter         = true
    # enable_secrets_store_csi_driver   = true
    # enable_vpa                        = true
  }
}

###############################################################################
# GitOps Addons Configuration
###############################################################################

variable "gitops_addons_org" {
  description = "Git repository org/user contains for addons"
  type        = string
  default     = "git@github.com:abhishek-kundalia"
}

variable "gitops_addons_repo" {
  description = "Git repository contains for addons"
  type        = string
  default     = "gitops-bridge"
}

variable "gitops_addons_revision" {
  description = "Git repository revision/branch/ref for addons"
  type        = string
  default     = "main"
}

variable "gitops_addons_basepath" {
  description = "Git repository base path for addons"
  type        = string
  default     = "eks-cluster-addons/"
}

variable "gitops_addons_path" {
  description = "Git repository path for addons"
  type        = string
  default     = "bootstrap/control-plane/addons"
}

###############################################################################
# GitOps Workload Configuration
###############################################################################

variable "gitops_workload_org" {
  description = "Git repository org/user contains for workload"
  type        = string
  default     = "git@github.com:abhishek-kundalia"
}

variable "gitops_workload_repo" {
  description = "Git repository contains for workload"
  type        = string
  default     = "gitops-bridge"
}

variable "gitops_workload_revision" {
  description = "Git repository revision/branch/ref for workload"
  type        = string
  default     = "main"
}

variable "gitops_workload_basepath" {
  description = "Git repository base path for workload"
  type        = string
  default     = ""
}

variable "gitops_workload_path" {
  description = "Git repository path for workload"
  type        = string
  default     = "eks-app-workloads"
}

###############################################################################
# Ingress and Certificate Configuration
###############################################################################

variable "enable_ingress" {
  description = "Enable ingress for the cluster"
  type        = bool
  default     = true
}

variable "acm_validation_method" {
  description = "Method to validate ACM certificate"
  type        = string
  default     = "DNS"
}
