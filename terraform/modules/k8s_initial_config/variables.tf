variable "accesskeyid" {
  default = "none"
}

variable "client_id" {
  default = "none"
}

variable "client_secret" {
  default = "none"
}

variable "cloud_platform" {
  default = "azure"
}

variable "dns_zone_name" {
  default = "myexample.dev"
}

variable "email" {
  default = "petr.ruzicka@gmail.com"
}

variable "full_kubernetes_cluster_name" {
  default = "k8s-mytest"
}

variable "helm_cert-manager_version" {
  default = "v0.10.0"
}

variable "helm_external-dns_version" {
  default = "2.6.0"
}

variable "helm_istio_version" {
  default = "1.2.6"
}

variable "helm_kubed_version" {
  default = "v0.11.0"
}

variable "kubeconfig" {}

variable "letsencrypt_environment" {
  default = "staging"
}

variable "location" {
  default = "eu-central-1"
}

variable "prefix" {
  default = "mytest"
}

variable "resource_group_name" {
  default = "terraform_resource_group_name"
}

variable "resource_group_name_dns" {
  description = "Resource group where Terrafrom can locate DNS zone (myexample.dev)"
  default     = "terraform_resource_group_name-dns"
}

variable "secret_access_key" {
  default = "none"
}

variable "subscription_id" {
  default = "none"
}

variable "tenant_id" {
  default = "none"
}
