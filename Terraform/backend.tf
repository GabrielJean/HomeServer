terraform {
  backend "azurerm" {
    resource_group_name   = var.azure_resource_group_name
    storage_account_name  = var.azure_storage_account_name
    container_name        = var.azure_storage_container_name
    key                   = var.azure_backend_key
    storage_account_key   = var.azure_storage_account_key
  }
}
