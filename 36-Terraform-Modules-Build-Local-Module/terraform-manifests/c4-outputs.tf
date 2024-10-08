# Output variable definitions
output "root_resource_group_id" {
  description = "resource group id"
  value       = module.azure_static_website.resource_group_id
}
output "root_resource_group_name" {
  description = "The name of the resource group"
  value       = module.azure_static_website.resource_group_name
}
output "root_resource_group_location" {
  description = "resource group location"
  value       = module.azure_static_website.resource_group_location
}
output "root_storage_account_id" {
  description = "storage account id"
  value       = module.azure_static_website.storage_account_id
}
output "root_storage_account_name" {
  description = "storage account name"
  value       = module.azure_static_website.storage_account_name
}
output "root_virtual_network_name" {
  description = "Virtual Network Name"
  value       = module.azure-virtual-network-4tier.virtual_network_name
}
output "root_virtual_network_id" {
  description = "Virtual Network ID"
  value       = module.azure-virtual-network-4tier.virtual_network_id
}
output "root_web_subnet_name" {
  description = "WebTier Subnet Name"
  value       = module.azure-virtual-network-4tier.web_subnet_name
}
output "root_web_subnet_id" {
  description = "WebTier Subnet ID"
  value       = module.azure-virtual-network-4tier.web_subnet_id
}
output "root_web_subnet_nsg_name" {
  description = "WebTier Subnet NSG Name"
  value       = module.azure-virtual-network-4tier.web_subnet_nsg_name
}
output "root_web_subnet_nsg_id" {
  description = "WebTier Subnet NSG ID"
  value       = module.azure-virtual-network-4tier.web_subnet_nsg_id
}
