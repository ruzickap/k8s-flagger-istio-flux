variable "admin_username" {
  default = "ubuntu"
}

variable "client_id" {}

variable "client_secret" {}

variable "cloud_platform" {
  default = "azure"
}

variable "dns_zone_name" {
  default = "myexample.dev"
}

variable "kubernetes_cluster_name" {
  description = "Name for the Kubernetes cluster (will be used as part of the doman) [k8s.myexample.dev]"
  default     = "k8s"
}

variable "kubernetes_version" {
  default = "1.14.6"
}

variable "letsencrypt_environment" {
  default = "staging"
}

variable "location" {
  default = "uksouth"
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

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "subscription_id" {}

variable "tags" {
  default = {
    Owner       = "pruzicka"
    Environment = "Testing"
  }
}

variable "tenant_id" {}

variable "vm_disk_size" {
  default = 30
}

variable "vm_size" {
  default = "Standard_B2s"
}

variable "vm_count" {
  default = 1
}
