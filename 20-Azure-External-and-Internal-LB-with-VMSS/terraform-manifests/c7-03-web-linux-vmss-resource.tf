## Define a Public IP Address for the NAT Gateway
#resource "azurerm_public_ip" "nat_public_ip" {
#  name                = "WebVMSS-NAT-PublicIP"
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  allocation_method   = "Static"
#  sku                 = "Standard"
#}
#
## Define the NAT Gateway
#resource "azurerm_nat_gateway" "nat_gw" {
#  name                	  = "Web-VMSS-NATGW"
#  resource_group_name 	  = azurerm_resource_group.rg.name
#  location            	  = azurerm_resource_group.rg.location
#  sku_name           	  = "Standard"
#}
#
## Associate the Public IP Address with the NAT Gateway
#resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip" {
#  nat_gateway_id         = azurerm_nat_gateway.nat_gw.id
#  public_ip_address_id   = azurerm_public_ip.nat_public_ip.id
#}
#
## Associate the NAT Gateway with the Private Subnet
#resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gw_assoc" {
#  subnet_id      = azurerm_subnet.websubnet.id
#  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
#}
# Locals Block for custom data
# Locals Block for custom data
locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/webvm
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/webvm/hostname.html
sudo echo "Welcome to stacksimplify - WebVM App1 - App Status Page" > /var/www/html/webvm/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/webvm/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/webvm/metadata.html
sudo sh -c 'echo -e "[azure-cli] 
name=Azure CLI 
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install -y azure-cli
sudo cd /etc/httpd/conf.d
sudo az storage blob download -c ${azurerm_storage_container.httpd_files_container.name} -f /etc/httpd/conf.d/app1.conf -n app1.conf --account-name ${azurerm_storage_account.storage_account.name} --account-key ${azurerm_storage_account.storage_account.primary_access_key}
sudo systemctl reload httpd
/usr/sbin/setsebool -P httpd_can_network_connect 1 
CUSTOM_DATA  
}

# Resource: Azure Linux Virtual Machine Scale Set - App1
resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name                = "${local.resource_name_prefix}-web-vmss"
  #computer_name_prefix = "vmss-app1" # if name argument is not valid one for VMs, we can use this for VM Names
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  upgrade_mode = "Automatic"
  
  network_interface {
    name    = "web-vmss-nic"
    primary = true
    network_security_group_id = azurerm_network_security_group.web_vmss_nsg.id
    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.websubnet.id  
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
    }
  }
  #custom_data = filebase64("${path.module}/app-scripts/redhat-app1-script.sh")      
  custom_data = base64encode(local.webvm_custom_data)  
}
  

