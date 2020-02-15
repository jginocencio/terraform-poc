#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}


variable "vnet_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "subnet_names" {
  type    = list(string)
  default = ["default"]
}

#############################################################################
# RESOURCES
#############################################################################

module "vnet-main" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "${var.resource_group_name}-Vnet"
  address_space       = var.vnet_cidr_range
  subnet_prefixes     = var.subnet_prefixes
  subnet_names        = var.subnet_names
  nsg_ids             = {}

}

#############################################################################
# OUTPUTS
#############################################################################

output "vnet_id" {
  value = module.vnet-main.vnet_id
}

output "vnet_name" {
  value = module.vnet-main.vnet_name
}

