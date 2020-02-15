#############################################################################
# Provider
#############################################################################
provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id = "${var.client_id}"
    client_secret = "${var.client_secret}"
    tenant_id = "${var.tenant_id}"
}

#############################################################################
# VARIABLES
#############################################################################

variable "subscription_id" {
  description = "Subscription ID"
}

variable "client_id" {
  description = "Client ID"
}

variable "client_secret" {
  description = "client_secret"
}

variable "tenant_id" {
  description = "tenant_id"
}

variable "organization" {
  default = "dom"
  description = "Organization Name"
}

variable "dc01_hostName" {
  default = "DC01"
}

variable "web01_hostName" {
  default = "WEB01"
}

variable "db01_hostName" {
  default = "DB01"
}

variable "admin_username" {
  description = "VM admin Username"
  default = "myAdmin"
}

variable "admin_password" {
  description = "VM admin password"
  default = "P@ssw0rd123!!!"
}

variable "domain_cotroller_private_ip"{
  description = "domain controller private ip"
  default = "10.0.0.10"
}

variable "web_host01_private_ip"{
  description = "domain controller private ip"
  default = "10.0.0.11"
}

variable "db_host01_private_ip"{
  description = "domain controller private ip"
  default = "10.0.0.12"
}

variable "subnet_name" {
  description = "subnet name"
  default = "default"
}

