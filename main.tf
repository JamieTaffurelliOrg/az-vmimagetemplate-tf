resource "azurerm_resource_group_template_deployment" "windows_image_template" {
  for_each            = { for k in var.windows_image_templates : k.name => k }
  name                = each.key
  resource_group_name = var.resource_group_name
  template_content    = file("arm/windowsImageTemplate.json")
  parameters_content = jsonencode({
    "imageTemplateName" = {
      value = each.key
    },
    "location" = {
      value = var.location
    },
    "userAssignedIdentityId" = {
      value = data.azurerm_user_assigned_identity.image.id
    },
    "galleryImageId" = {
      value = data.azurerm_shared_image.image["${each.key}-${each.value.image_name}"].id
    },
    "sourceImagePublisher" = {
      value = data.azurerm_shared_image.image["${each.key}-${each.value.image_name}"].identifier[0].publisher
    },
    "sourceImageOffer" = {
      value = data.azurerm_shared_image.image["${each.key}-${each.value.image_name}"].identifier[0].offer
    },
    "sourceImageSku" = {
      value = data.azurerm_shared_image.image["${each.key}-${each.value.image_name}"].identifier[0].sku
    },
    "artifactTags" = {
      value = each.value["artifact_tags"]
    },
    "hardeningScriptUrl" = {
      value = each.value["hardening_script_url"]
    }
    "tags" = {
      value = var.tags
    }
  })
  deployment_mode = "Incremental"
}
