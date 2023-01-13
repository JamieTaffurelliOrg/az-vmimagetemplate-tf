data "azurerm_user_assigned_identity" "image" {
  name                = var.user_assigned_identity_name
  resource_group_name = var.resource_group_name
}

data "azurerm_shared_image" "image" {
  for_each            = { for k in var.windows_image_templates : "${k.name}-${k.image_name}" => k }
  name                = each.value["image_name"]
  gallery_name        = var.gallery_name
  resource_group_name = var.resource_group_name
}
