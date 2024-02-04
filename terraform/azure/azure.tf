data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

# kics-scan ignore-line
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "${var.prefix}-${var.kubernetes_cluster_name}-${replace(var.dns_zone_name, ".", "-")}"
  location            = var.location
  kubernetes_version  = var.kubernetes_version
  resource_group_name = var.resource_group_name
  dns_prefix          = var.kubernetes_cluster_name

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = file("${var.ssh_public_key}")
    }
  }

  agent_pool_profile {
    name            = "${var.prefix}${var.kubernetes_cluster_name}"
    count           = var.vm_count
    vm_size         = var.vm_size
    os_type         = "Linux"
    os_disk_size_gb = var.vm_disk_size
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = var.tags
}


resource "local_file" "file" {
  content  = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
  filename = "../kubeconfig_${var.prefix}-${var.kubernetes_cluster_name}-${replace(var.dns_zone_name, ".", "-")}"
}

module "k8s_initial_config" {
  source = "../modules/k8s_initial_config"

  client_id                    = var.client_id
  client_secret                = var.client_secret
  cloud_platform               = var.cloud_platform
  dns_zone_name                = var.dns_zone_name
  kubeconfig                   = local_file.file.filename
  full_kubernetes_cluster_name = azurerm_kubernetes_cluster.kubernetes_cluster.name
  letsencrypt_environment      = var.letsencrypt_environment
  prefix                       = var.prefix
  resource_group_name_dns      = var.resource_group_name_dns
  resource_group_name          = var.resource_group_name
  subscription_id              = var.subscription_id
  tenant_id                    = var.tenant_id
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}${var.kubernetes_cluster_name}${replace(var.dns_zone_name, ".", "")}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  tags                = var.tags
}
