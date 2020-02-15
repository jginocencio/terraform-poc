#############################################################################
# VARIABLES
#############################################################################

variable "agent_resource_group" {
  type = string
  default = "MyAgents"
}

variable "agent_virtual_network_name" {
    type = string
    default = "MyAgents-Vnet"
}

variable "main_resoure_group_name" {
    type = string
}

variable "main_vnet_name" {
    type = string
}

variable "main_vnet_id" {
    type = string
}

#############################################################################
# DATASOURCES
#############################################################################

data "azurerm_virtual_network" "agent_vnet" {
  name                = "${var.agent_virtual_network_name}"
  resource_group_name = "${var.agent_resource_group}"
}


#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_virtual_network_peering" "main" {
  name                      = "main_2_sec"
  resource_group_name       = var.main_resoure_group_name
  virtual_network_name      = var.main_vnet_name
  remote_virtual_network_id = data.azurerm_virtual_network.agent_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "sec" {
  name                      = "sec_2_main"
  resource_group_name       = var.agent_resource_group
  virtual_network_name      = var.agent_virtual_network_name
  remote_virtual_network_id = var.main_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

#############################################################################
# OUTPUTS
#############################################################################