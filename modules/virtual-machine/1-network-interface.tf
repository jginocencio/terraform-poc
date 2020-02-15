resource "azurerm_public_ip" "static" {
  name                         = "${var.hostname}-nic-pip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  allocation_method = "Static"
}

resource "azurerm_network_interface" "primary" {
  name                    = "${var.hostname}-nic"
  location                = "${var.location}"
  resource_group_name     = "${var.resource_group_name}"
  internal_dns_name_label = "${var.hostname}"

  ip_configuration {
    name                          = "primary"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${var.network_interface_private_ip}"
    public_ip_address_id          = "${azurerm_public_ip.static.id}"

  }
}
