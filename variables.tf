# -----------------------------------------------------------------------------
# Terraform Snowflake Table Module
# -----------------------------------------------------------------------------
# This module creates and manages Snowflake tables using a map-based
# configuration. It supports creating single or multiple tables with
# columns, primary keys, clustering, change tracking, and data retention
# settings in a single module call.
# -----------------------------------------------------------------------------

variable "table_configs" {
  description = "Map of configuration objects for Snowflake tables"
  type = map(object({
    database                    = string
    schema                      = string
    name                        = string
    table_type                  = optional(string, "PERMANENT")
    drop_before_create          = optional(bool, false)
    comment                     = optional(string, null)
    cluster_by                  = optional(list(string), null)
    data_retention_time_in_days = optional(number, 1)
    change_tracking             = optional(bool, false)
    columns = list(object({
      name          = string
      type          = string
      nullable      = optional(bool, true)
      default       = optional(string, null)
      comment       = optional(string, null)
      autoincrement = optional(object({
        start     = optional(number, 1)
        increment = optional(number, 1)
        order     = optional(bool, false)
      }), null)
    }))
    primary_key = optional(object({
      name = optional(string, null)
      keys = list(string)
    }), null)
  }))
  default = {}

  validation {
    condition     = alltrue([for k, tbl in var.table_configs : length(tbl.name) > 0])
    error_message = "Table name must not be empty."
  }

  validation {
    condition     = alltrue([for k, tbl in var.table_configs : length(tbl.database) > 0])
    error_message = "Database name must not be empty."
  }

  validation {
    condition     = alltrue([for k, tbl in var.table_configs : length(tbl.schema) > 0])
    error_message = "Schema name must not be empty."
  }

  validation {
    condition     = alltrue([for k, tbl in var.table_configs : length(tbl.columns) > 0])
    error_message = "Table must have at least one column."
  }

  validation {
    condition     = alltrue([for k, tbl in var.table_configs : tbl.data_retention_time_in_days >= 0 && tbl.data_retention_time_in_days <= 90])
    error_message = "data_retention_time_in_days must be between 0 and 90."
  }

  validation {
    condition     = alltrue([for k, tbl in var.table_configs : contains(["PERMANENT", "TRANSIENT", "TEMPORARY"], tbl.table_type)])
    error_message = "table_type must be one of: PERMANENT, TRANSIENT, TEMPORARY."
  }
}
