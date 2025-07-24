
# Create a resource group

resource "azurerm_resource_group" "resourceall" {
  name     = "storage_resource"
  location = var.location
}

resource "azurerm_storage_account" "workspacestorage" {
  name                     = "storagekeybucket"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.resourceall.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "storage_container" {
  name                  = "storagecontainer"
  storage_account_name    = azurerm_storage_account.workspacestorage.name
  container_access_type = "private"
}

