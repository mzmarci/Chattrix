output "nic" {
  value = azurerm_network_interface.nic.id
}

output "nsg" {
  value = azurerm_network_security_group.nsg.id
}