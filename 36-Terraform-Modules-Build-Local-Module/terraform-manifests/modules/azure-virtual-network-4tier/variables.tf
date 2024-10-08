variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
}
variable "location" {
  description = "Region in which Azure Resources to be created"
  type = string
}
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
}
variable "web_subnet_name" {
  description = "Virtual Network Web Subnet Name"
  type = string
}
variable "web_subnet_address" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
}
#variable "app_subnet_name" {
#  description = "Virtual Network App Subnet Name"
#  type = string
#}
#variable "app_subnet_address" {
#  description = "Virtual Network App Subnet Address Spaces"
#  type = list(string)
#}

