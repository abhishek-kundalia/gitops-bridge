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


variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones_count" {
  description = "Number of Availability Zones to use"
  type        = number
  default     = 2
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
variable "addons" {
  description = "Kubernetes addons"
  type        = any
  default = {
    enable_cert_manager                          = true
    # enable_aws_efs_csi_driver                    = true
    # enable_aws_fsx_csi_driver                    = true
    # enable_aws_cloudwatch_metrics                = true
    # enable_aws_privateca_issuer                  = true
    # enable_cluster_autoscaler                    = true
    enable_argo_workflows               = false # set to false if enable_aws_argo_workflows_ingress = true
    enable_aws_argo_workflows_ingress   = true # set to true if enable_argo_workflows is false

    enable_external_dns                 = true # set to true if enable_aws_argo_workflows_ingress = true
    # enable_external_dns                          = true

    enable_aws_load_balancer_controller          = true
    enable_aws_argocd_ingress           = true
    enable_aws_ebs_csi_resources                 = true # generate gp2 and gp3 storage classes for ebs-csi
    enable_external_secrets                      = true

    # enable_aws_for_fluentbit                     = true
    # enable_aws_node_termination_handler          = true
    # enable_karpenter                             = true
    # enable_velero                                = true
    # enable_aws_gateway_api_controller            = true

    # enable_aws_secrets_store_csi_driver_provider = true
    # enable_argo_rollouts                         = true
    # # enable_argo_workflows                        = true
    # enable_gpu_operator                          = true
    # enable_kube_prometheus_stack                 = true
    # enable_metrics_server                        = true
    # enable_prometheus_adapter                    = true
    # enable_secrets_store_csi_driver              = true
    # enable_vpa                                   = true
    # enable_foo                                   = true 
  }
}
# Addons Git
variable "gitops_addons_org" {
  description = "Git repository org/user contains for addons"
  type        = string
  default     = "https://github.com/abhishek-kundalia"
}
variable "gitops_addons_repo" {
  description = "Git repository contains for addons"
  type        = string
  default     = "gitops-bridge-argocd-control-plane"
}
variable "gitops_addons_revision" {
  description = "Git repository revision/branch/ref for addons"
  type        = string
  default     = "main"
}
variable "gitops_addons_basepath" {
  description = "Git repository base path for addons"
  type        = string
  default     = ""
}
variable "gitops_addons_path" {
  description = "Git repository path for addons"
  type        = string
  default     = "bootstrap/control-plane/addons"
}

# Workloads Git
variable "gitops_workload_org" {
  description = "Git repository org/user contains for workload"
  type        = string
  default     = "https://github.com/abhishek-kundalia"
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
  default     = "argocd/iac/terraform/examples/eks/"
}
variable "gitops_workload_path" {
  description = "Git repository path for workload"
  type        = string
  default     = "getting-started/k8s"
}
