variable "subscription" {
  description = "Subscription name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "env" {
  description = "Prod or Dev"
  type        = string
  default     = "PRD"
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
}

variable "address_space" {
  description = "Address space"
  type        = list(string)
}

variable "subnet_names" {
  description = "Subnet names"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "Subnet CIDRs"
  type        = list(string)
}

variable "vdc_prefix" {
  description = "First three octets of the VDC range"
  type        = string
}

variable "vdc_mask" {
  description = "VDC range's mask length (default is /24)"
  type        = string
  default     = "/24"
}