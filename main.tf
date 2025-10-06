data "azurerm_resource_group" "example" {
  name     = "813-9e9e7bbc-hands-on-with-terraform-on-azure" #need to update
}

resource "azurerm_service_plan" "example" {
  name                = "${var.company}${var.environment}asp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name = "S1"
}

resource "azurerm_linux_web_app" "example" {
  name                = "${var.company}${var.environment}as"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id = azurerm_service_plan.example.id
  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }
}

resource "azurerm_linux_web_app_slot" "example" {
  name                = "${var.company}${var.environment}asstaging"
  app_service_id    = azurerm_linux_web_app.example.id
  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }
}
