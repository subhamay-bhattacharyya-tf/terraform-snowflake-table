# -----------------------------------------------------------------------------
# Terraform Snowflake Table Module
# -----------------------------------------------------------------------------
# This module creates and manages Snowflake tables using a map-based
# configuration. It supports creating single or multiple tables with
# configurable sizes, auto-suspend, and scaling policies in a single module
# call.
# -----------------------------------------------------------------------------

resource "snowflake_table" "this" {
  for_each = var.table_configs

  database                    = each.value.database
  schema                      = each.value.schema
  name                        = each.value.name
  comment                     = lookup(each.value, "comment", null)
  cluster_by                  = lookup(each.value, "cluster_by", null)
  data_retention_time_in_days = lookup(each.value, "data_retention_time_in_days", 1)
  change_tracking             = lookup(each.value, "change_tracking", false)

  dynamic "column" {
    for_each = each.value.columns
    content {
      name     = column.value.name
      type     = column.value.type
      nullable = lookup(column.value, "nullable", true)
      default {
        constant = lookup(column.value, "default", null)
      }
      comment = lookup(column.value, "comment", null)
    }
  }

  dynamic "primary_key" {
    for_each = lookup(each.value, "primary_key", null) != null ? [each.value.primary_key] : []
    content {
      name = lookup(primary_key.value, "name", null)
      keys = primary_key.value.keys
    }
  }
}
