resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = local.dns_servers
}

resource "azurerm_subnet" "subnet" {
  for_each = local.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [each.value]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_route_table" "route_tables" {
  for_each = local.subnets

  name                          = "${each.key}_route_table_01"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = true

  route {
    name                   = "Internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${var.vdc_prefix}.10"
  }

  route {
    name           = "Route_to_${each.key}"
    address_prefix = each.value
    next_hop_type  = "VnetLocal"
  }

  route {
    name                   = "Hub_${location}"
    address_prefix         = "${var.vdc_prefix}.0${var.vdc_mask}"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${var.vdc_prefix}.10"
  }
}

resource "azurerm_subnet_route_table_association" "rt-to-subnet" {
  for_each = local.subnets

  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.route_tables[each.key].id
}