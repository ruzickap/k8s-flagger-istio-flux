variable "accesskeyid" {}

variable "cloud_platform" {
  default = "aws"
}

variable "dns_zone_name" {
  default = "mylabs.dev"
}

variable "kubernetes_cluster_name" {
  description = "Name for the Kubernetes cluster (will be used as part of the doman) [k8s.myexample.dev]"
  default     = "k8s"
}

variable "letsencrypt_environment" {
  default = "staging"
}

variable "location" {
  default = "eu-central-1"
}

variable "prefix" {
  default = "mytest"
}

variable "secret_access_key" {}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  default = {
    Owner       = "pruzicka"
    Environment = "Testing"
  }
}

variable "vm_count" {
  default = 2
}

variable "vm_disk_size" {
  default = 10
}

variable "vm_size" {
  default = "t3-micro"
}
