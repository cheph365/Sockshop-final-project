# Define input variables
variable "ARM_SUBSCRIPTION_ID" {
  type        = string
  description = "Azure subscription ID"
}

variable "ARM_CLIENT_ID" {
  type        = string
  description = "Service principal client ID"
}

variable "ARM_CLIENT_SECRET" {
  type        = string
  description = "Service principal client secret"
}

variable "ARM_TENANT_ID" {
  type        = string
  description = "Azure Active Directory tenant ID"
}
variable "node_count" {
  description = "Number of nodes in the Kubernetes cluster"
  type        = number
  # You can set a default value if needed
  default     = 3
}

variable "username" {
  description = "Username for the Kubernetes cluster nodes"
  type        = string
  # You can set a default value if needed
  default     = "azureadmin"
}
# Configure Azure provider using variables
provider "azurerm" {
  features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
}

# Generate random resource group name
resource "azurerm_resource_group" "rg" {
  name     = "Capstone_Cluster"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "Capstone-aks1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "Capstoneaks1"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}
