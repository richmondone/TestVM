locals { 
    azure_resource_tags_defaults = {
        
        Cost_Manager        = "brian.uhreen@finning.com",
        Service_Owner       = "brian.uhreen@finning.com",
        Service_Name        = "IIQ",
        Cost_Area           = "security",
        Project_Code        = "S58IIQUE",
        Environment         = "QA",
        Technical_Owner     = "brian.uhreen@finning.com",
        Expiration_Date     = "2023-12-01",
        Tag_Audit_Date      = "12-23-2020",
        SLA                 = "finninginternationl-8x5",
        Region              = "global",
        Deployment_Type     = "QA",
        Auto_Shutdown       = "custom_schedule"
        Technical_Owner2    = "maneet.puri@finning.com"
        Custom_Power_Schedule   = "23=00"
        }
}

/*locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Cost_Manager            =   local.Cost_Manager
    Service_Owner           =   local.Service_Owner
    Service_Name            =   local.Service_Owner
    Cost_Area               =   local.Cost_Area
    Project_Code            =   local.Project_Code
    Environment             =   local.Environment
    Technical_Owner         =   local.Technical_Owner
    Expiration_Date         =   local.Expiration_Date
    Tag_Audit_Date          =   local.Tag_Audit_Date
    SLA                     =   local.SLA
    Region                  =   local.Region
    Deployment_Type         =   local.Deployment_Type
    Auto_Shutdown           =   local.Auto_Shutdown
    Technical_Owner2        =   local.Technical_Owner2
    Custom_Power_Schedule   =   local.Custom_Power_Schedule
  }
}*/