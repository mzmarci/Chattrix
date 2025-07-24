resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "private_subnet" {
  //count                = var.private_subnet_count
  name                 = "private-subnet1"    //${count.index + 1
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_public_ip" "public_subnet" {
  name                = "public_subnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # Use "Dynamic" if you prefer
  sku = "Standard"  # "Basic" is also available, but "Standard" is preferred for production
  idle_timeout_in_minutes = 30   // It’s the maximum time (in minutes) a TCP/HTTP connection can remain idle before Azure closes it.

}