variable "count" {default  = "1"}
variable "numberOfVM" {default = 1}
variable "vmname" { default = "qa-iiq-vm"}
variable "location" {default = "eastus"}
variable "prefix" { default = "0"}
variable "networkInterfaceName" {default = "trustedinterface01"}
variable "virtualNetworkName" {default = "OneNet-VirtualNetwork"}
variable "subnetName" {default = "Windows-Trusted-Subnet"}
//variable "virtualNetworkId" {default = "/subscriptions/4e9802df-cff3-487a-94d4-222c2d576861/resourceGroups/MYVMs/providers/Microsoft.Network/virtualNetworks/OneNet-VirtualNetwork"}
variable "required_tags" {
    type = "map" 
        default = { Cost_Manager= "puri.maneet@icloud.com"
                    Service_Owner= "maneetny@icloud.com"
                    Service_Name= "ONECanada"
                    Cost_Area= "security"
                    Project_Code= "S58IIQUE"
                    Environment= "Dev"
                    Technical_Owner= "brian.uhreen@finning.com"
                    Expiration_Date= "2023-12-01"
                    Tag_Audit_Date= "12-23-2020"
                    SLA= "finninginternationl-8x5"
                    Region = "Canada"
                    Custom_Power_Schedule= "N/A"
                    Deployment_Type= "Dev"
                    Auto_Shutdown= "custom_schedule"
                    Technical_Owner = "maneet.puri@finning.com"
    }

}