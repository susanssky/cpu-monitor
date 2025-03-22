
# resource "azurerm_storage_account" "storage_account" {
#   name                     = "${replace(local.project_name, "-", "")}forstorage"
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
# }


# resource "azurerm_storage_account_static_website" "test" {
#   storage_account_id = azurerm_storage_account.storage_account.id
#   error_404_document = "index.html"
#   index_document     = "index.html"
# }


# resource "azurerm_storage_blob" "storage_blob" {
#   for_each = fileset("../../app/client/dist", "**") 

#   name                   = each.value
#   storage_account_name   = azurerm_storage_account.storage_account.name
#   storage_container_name = "$web" 
#   type                   = "Block"
#   source                 = "../../app/client/dist/${each.value}"
#   content_type = lookup({
#     ".html" = "text/html",
#     ".js"   = "application/javascript",
#     ".css"  = "text/css",
#     ".png"  = "image/png",
#     ".jpg"  = "image/jpeg"
#   }, regex("\\.[^.]+$", each.value), "application/octet-stream")
#   # depends_on = [  ]
# }
# output "static_website_url" {
#   value = azurerm_storage_account.storage_account.primary_web_endpoint
# }
