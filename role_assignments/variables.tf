variable "scopes" {
  description = "List of scopes where the role will be assigned"
  type        = list(string)
  default     = []
}

variable "scope" {
  description = "The scope where the role will be assigned (optional if scopes is used)"
  type        = string
  default     = null
}

variable "role_definition_name" {
  description = "The name of the role definition to assign"
  type        = string
}

variable "principal_id" {
  description = "The ID of the principal to assign the role to"
  type        = string
}

variable "principal_type" {
  description = "The type of principal (User, Group, ServicePrincipal, ForeignGroup)"
  type        = string
  default     = "ServicePrincipal"
  
}

variable "description" {
  description = "Description of the role assignment"
  type        = string
  default     = ""
}

variable "role_assignments" {
  description = "Map of role assignments to create"
  type = map(object({
    scope                = string
    role_definition_id   = optional(string)
    role_definition_name = optional(string)
    principal_id         = optional(string)
    principal_type       = optional(string)
    description          = optional(string)
    skip_sp_aad_check    = optional(bool)
  }))
  default = {}
}

variable "skip_service_principal_aad_check" {
  description = "Skip service principal AAD check"
  type        = bool
  default     = false
}