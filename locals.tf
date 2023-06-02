locals {
  subnets     = zipmap(var.subnet_names, var.subnet_cidrs)
  dns_servers = ["${var.vdc_prefix}.10", "${var.vdc_prefix}.11"]
  loc_code    = element(split("_", var.vnet_name), 1)
}

