# Call our Custom Terraform Module which we built earlier
module "azure_static_website" {
  source = "./modules/azure-static-website" # Mandatory

  # Resource Group
  location            = "southeastasia"
  resource_group_name = "demorg01"

  # Storage Account
  storage_account_name              = "staticwebsite"
  storage_account_tier              = "Standard"
  storage_account_replication_type  = "LRS"
  storage_account_kind              = "StorageV2"
  static_website_index_document     = "index.html"
  static_website_error_404_document = "error.html"
}
module "azure-virtual-network-4tier" {
  source = "./modules/azure-virtual-network-4tier" # Mandatory

  # Resource Group
  location            = "southeastasia"
  resource_group_name = "demorg01"

  #vNet Resource
  vnet_name          = "demovnet"
  vnet_address_space = ["10.1.0.0/16"]

  #Subnet Resource
  web_subnet_name    = "websubnet"
  web_subnet_address = ["10.1.111.0/24"]
}
