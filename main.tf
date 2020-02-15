#############################################################################
# DATASOURCES
#############################################################################

data "azurerm_subnet" "default-subnet" {
  name                 = var.subnet_name
  virtual_network_name = module.group-vnet.vnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on = [module.group-vnet]
}

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_resource_group" "rg" {
  name = "Devops-Lab"
  location = "southeastasia"
}

#############################################################################
# MODULES
#############################################################################

module "group-vnet" {
  source                    = "./modules/virtual-network"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

module "group-vnet-2-agent-vnet-peering" {
  source                    = "./modules/virtual-network-peering"
  main_resoure_group_name = azurerm_resource_group.rg.name
  main_vnet_name = module.group-vnet.vnet_name
  main_vnet_id   = module.group-vnet.vnet_id
}

module "DomainController01" {
  source                    = "./modules/virtual-machine"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  hostname                  = var.dc01_hostName
  organization              = var.organization
  subnet_id                 = data.azurerm_subnet.default-subnet.id
  network_interface_private_ip = var.domain_cotroller_private_ip
  admin_username            = var.admin_username
  admin_password            = var.admin_password
}

module "WebHost01" {
  source                    = "./modules/virtual-machine"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  hostname                  = var.web01_hostName
  organization              = var.organization
  subnet_id                 = data.azurerm_subnet.default-subnet.id
  network_interface_private_ip = var.web_host01_private_ip
  admin_username            = var.admin_username
  admin_password            = var.admin_password
}

module "DbHost01" {
  source                    = "./modules/virtual-machine"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  hostname                  = var.db01_hostName
  organization              = var.organization
  subnet_id                 = data.azurerm_subnet.default-subnet.id
  network_interface_private_ip = var.db_host01_private_ip
  admin_username            = var.admin_username
  admin_password            = var.admin_password
}

