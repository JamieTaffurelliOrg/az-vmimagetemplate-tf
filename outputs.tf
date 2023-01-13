output "windows_image_template_resource_id" {
  value       = { for k, v in jsondecode(azurerm_resource_group_template_deployment.windows_image_template[*].output_content).resourceID.value : k => v }
  description = "Resource ID of the image template"
}
