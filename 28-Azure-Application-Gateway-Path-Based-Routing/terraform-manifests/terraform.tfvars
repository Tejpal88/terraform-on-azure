business_divsion = "Infra"
environment = "Prod"
resource_group_name = "demorg1"
resource_group_location = "southeastasia"
vnet_name = "denmovnet1"
vnet_address_space = ["10.1.0.0/16"]

web_subnet_name = "websubnet"
web_subnet_address = ["10.1.1.0/24"]

app_subnet_name = "appsubnet"
app_subnet_address = ["10.1.11.0/24"]

db_subnet_name = "dbsubnet"
db_subnet_address = ["10.1.21.0/24"]

bastion_subnet_name = "bastionsubnet"
bastion_subnet_address = ["10.1.100.0/24"]

#bastion_service_subnet_name = "AzureBastionSubnet"
#bastion_service_address_prefixes = ["10.1.101.0/27"]

app1_web_vmss_nsg_inbound_ports = [22, 80, 443, 53]
app2_web_vmss_nsg_inbound_ports = [22, 80, 443, 53]

ag_subnet_name = "agsubnet"
ag_subnet_address = ["10.1.82.0/24"]
