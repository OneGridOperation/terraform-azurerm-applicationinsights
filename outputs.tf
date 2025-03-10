output "azurerm_application_insights" {
  description = "The Azure Application Insights resource."
  value       = azurerm_application_insights.application_insights
}

output "azurerm_application_insights_web_test" {
  description = "The Azure Application Insights Web Test resource."
  value       = local.web_test
}
