terraform {
  backend "azurerm" {
    resource_group_name  = "NewResource"
    storage_account_name = "sockshop"
    container_name       = "sockshopstatefile"
    key                  = "terraform.tfstate"
 }
}