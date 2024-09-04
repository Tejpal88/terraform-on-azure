# VM Scale Set Outputs

output "web_vmss_id" {
  description = "Web Virtual Machine Scale Set ID"
  value = azurerm_linux_virtual_machine_scale_set.web_vmss.id 
}
output "nat_gw_public_IP" {
  description = "Nat Gateway Public IP"
  value = azurerm_public_ip.nat_public_ip.ip_address 
}

