# -----------------------------------------------------------------------------
# Single Table Example - Variables
# -----------------------------------------------------------------------------

variable "table_configs" {
  description = "Map of table configurations (override for testing)"
  type        = any
  default     = null
}

variable "snowflake_organization_name" {
  description = "Snowflake organization name"
  type        = string
  default     = null
}

variable "snowflake_account_name" {
  description = "Snowflake account name"
  type        = string
  default     = null
}

variable "snowflake_user" {
  description = "Snowflake user"
  type        = string
  default     = null
}

variable "snowflake_role" {
  description = "Snowflake role"
  type        = string
  default     = null
}

variable "snowflake_private_key" {
  description = "Snowflake private key"
  type        = string
  sensitive   = true
  default     = null
}
