data "azurerm_resource_group" "example" {
  name     = "813-cd34c1c0-hands-on-with-terraform-on-azure" #need to update
}

resource "azurerm_app_service_plan" "example" {
  name                = "${var.company}${var.environment}asp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "${var.company}${var.environment}as"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
    site_config {
      dotnet_framework_version = "v6.0"
      scm_type                 = "LocalGit"
    }
}

resource "azurerm_app_service_slot" "example" {
  name                = "${var.company}${var.environment}asstaging"
  app_service_name    = azurerm_app_service.example.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}
