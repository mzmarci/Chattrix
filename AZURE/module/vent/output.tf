output "vnet" {
  value = azurerm_virtual_network.vnet.name
}

output "private_subnet" {
  value = azurerm_subnet.private_subnet[*].id
}

output "public_subnet" {
  value = azurerm_public_ip.public_subnet.id
}