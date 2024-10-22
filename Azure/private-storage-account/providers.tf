terraform {
  required_version = ">=1.7.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.97.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.6.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.11.1"
    }
  }
}
