module "storage" {
  source   = "./module/storage"
  location = var.location
}

module "vnet" {
  source              = "./module/vent"
  location            = var.location
  resource_group_name = module.storage.resourceall
}

module "security" {
  source               = "./module/security"
  resource_group_name  = module.storage.resourceall
  subnet_id            = module.vnet.private_subnet[0]
  location             = var.location
  public_ip_address_id = module.vnet.public_subnet
}

module "aks" {
  source              = "./module/aks"
  location            = var.location
  resource_group_name = module.storage.resourceall
}