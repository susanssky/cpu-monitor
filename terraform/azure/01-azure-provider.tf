

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    resource_group_name  = "forGithubActions"
    storage_account_name = "cloudprojectstfstate"
    container_name       = "tfstate"
    key                  = "cpu-monitor.tfstate"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.project_name}-rg"
  location = "UK South"
}
