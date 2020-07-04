/*
  Output variable definitions for the Azure SQL database server resource
*/

output "server_id" {
  description = "The Microsoft SQL Server ID."
  value = azurerm_mssql_server.database_server.id
  sensitive = false
}

output "server_name" {
  description = "The Microsoft SQL Server ID."
  value = split("/", azurerm_mssql_server.database_server.id)[length(split("/", azurerm_mssql_server.database_server.id)) - 1]
  sensitive = false
}
