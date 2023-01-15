variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group to deploy to"
}

variable "location" {
  type        = string
  description = "Location to deploy resources"
}

variable "user_assigned_identity_name" {
  type        = string
  description = "Name of user assigned identity for image builder"
}

variable "gallery_name" {
  type        = string
  description = "Name of Shared Image Gallery"
}

variable "windows_image_templates" {
  type = list(object({
    name                 = string
    image_name           = string
    artifact_tags        = map(string)
    hardening_script_url = string
  }))
  description = "Windows image templates to deploy"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
