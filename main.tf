
# Create a resource group
resource "azurerm_resource_group" "pipeline" {
    name     = "pipeline"
    location = "East US"
}

# Create a virtual network in the web_servers resource group
resource "azurerm_virtual_network" "pipeline-network" {
  name                = "pipeline-network"
  address_space       = ["172.16.60.0/23"]
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.pipeline.name}"

  # 256 Addresses for our CI driven test kitchen network
  subnet {
    name           = "ci-kitchen-subnet"
    address_prefix = "172.16.60.0/24"
  }

  # 128 Address for our Chef Developers. Will give them room to use test kitchen from their workstations
  subnet {
    name           = "chefdevs-subnet"
    address_prefix = "172.16.61.0/25"
  }

  # 32 Addresses for our various servers. Chef, Aritfactory, Jenkins, etc.
  subnet {
    name           = "ci-servers-subnet"
    address_prefix = "172.16.61.128/27"
  }

  # 32 Addresses as a general sandbox
  subnet {
    name           = "pipeline-sandbox-subnet"
    address_prefix = "172.16.61.160/27"
  }

  # 64 Addresses as a DMZ for jump boxes, etc
  subnet {
    name           = "pipeline-dmz-subnet"
    address_prefix = "172.16.61.192/27"
  }

}
