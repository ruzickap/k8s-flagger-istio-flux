data "aws_availability_zones" "availability_zones" {
}

module "vpc" {
  source               = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
  name                 = "${var.prefix}-${var.kubernetes_cluster_name}.${var.dns_zone_name}-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = [data.aws_availability_zones.availability_zones.names[0], data.aws_availability_zones.availability_zones.names[1]]
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    map("kubernetes.io/cluster/${var.prefix}-${var.kubernetes_cluster_name}-${replace(var.dns_zone_name, ".", "-")}-eks", "shared"),
  )

  public_subnet_tags = merge(
    var.tags,
    map("kubernetes.io/cluster/${var.prefix}-${var.kubernetes_cluster_name}-${replace(var.dns_zone_name, ".", "-")}-eks", "shared"),
    map("kubernetes.io/role/elb", "1"),
  )
}

resource "aws_security_group" "security_group" {
  name        = "${var.prefix}-${var.kubernetes_cluster_name}.${var.dns_zone_name}-security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id
  tags        = var.tags

  # kics-scan ignore-line
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # kics-scan ignore-line
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.prefix}-${var.kubernetes_cluster_name}.${var.dns_zone_name}-key"
  public_key = file(var.ssh_public_key)
}

module "eks" {
  source                = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v6.0.0"
  cluster_name          = "${var.prefix}-${var.kubernetes_cluster_name}-${replace(var.dns_zone_name, ".", "-")}-eks"
  subnets               = module.vpc.public_subnets
  vpc_id                = module.vpc.vpc_id
  write_kubeconfig      = false
  write_aws_auth_config = false
  tags                  = var.tags

  worker_groups = [
    {
      asg_desired_capacity = var.vm_count
      asg_max_size         = var.vm_count
      enable_monitoring    = false
      instance_type        = var.vm_size

      key_name         = aws_key_pair.key_pair.key_name
      name             = "${var.prefix}-${var.kubernetes_cluster_name}-${var.dns_zone_name}-worker_group"
      public_ip        = true
      root_volume_size = var.vm_disk_size
    }
  ]
}

resource "local_file" "file" {
  content  = module.eks.kubeconfig
  filename = "../kubeconfig_${var.prefix}-${var.kubernetes_cluster_name}-${replace(var.dns_zone_name, ".", "-")}"
}

# I need to configure module dependency properly
# See: https://github.com/hashicorp/terraform/issues/10462
# Otherwise the deletion will remain broken
# -> All helm releases + k8s changes needs to be "removed" before terrafrom
# starts destroing the cluster
# (Currently cluster is beeing destroyed before helm charts are removed which
# is causing terraform dependency issues)

module "k8s_initial_config" {
  depends_on                   = [local_file.file] #<-- this must be working
  source                       = "../modules/k8s_initial_config"
  accesskeyid                  = var.accesskeyid
  cloud_platform               = var.cloud_platform
  dns_zone_name                = var.dns_zone_name
  kubeconfig                   = local_file.file.filename
  full_kubernetes_cluster_name = dirname(module.eks.cluster_id)
  letsencrypt_environment      = var.letsencrypt_environment
  location                     = var.location
  secret_access_key            = var.secret_access_key
}
