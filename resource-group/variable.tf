variable "location" {
  description = "Resource group location"
  type        = string
  default     = "eastus2"
}
variable "lock" {
  description = "Enable resource lock to prevent accidental deletion"
  type        = bool
  default     = false
}

variable "lock_count" {
  description = "Number of locks to create. Set to 1 if lock is enabled, otherwise 0."
  type        = number
  default     = 0
}

variable "lock_level" {
  description = "The level of the lock. Possible values are 'CanNotDelete' and 'ReadOnly'."
  type        = string
  default     = "CanNotDelete"
}

variable "client_code" {
  description = "Client code (2-4 chars)"
  type        = string
  default     = "brc"
}

variable "environment" {
  description = "Environment tag (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "region_short" {
  description = "Region short code (e.g., eus2 for eastus2)"
  type        = string
  default     = "eus2"
}

variable "component" {
  description = "Component name (3-6 chars)"
  type        = string
  default     = "app"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "tags" {
  default     = {}
  description = "Tags to apply to the resource group and resources within it"
  type        = map(any)
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

variable "name" {
  description = "allow engineer to replace naming convention, ideally this should not be set."
  default = ""
  type    = string

}