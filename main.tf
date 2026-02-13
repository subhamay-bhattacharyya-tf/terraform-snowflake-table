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
  comment                     = each.value.comment
  cluster_by                  = each.value.cluster_by
  data_retention_time_in_days = each.value.data_retention_time_in_days
  change_tracking             = each.value.change_tracking

  dynamic "column" {
    for_each = each.value.columns
    content {
      name     = column.value.name
      type     = column.value.type
      nullable = column.value.nullable

      dynamic "default" {
        for_each = column.value.default != null ? [column.value.default] : []
        content {
          constant = default.value
        }
      }

      comment = column.value.comment
    }
  }
}

resource "snowflake_table_constraint" "primary_key" {
  for_each = { for k, v in var.table_configs : k => v if v.primary_key != null }

  name     = each.value.primary_key.name != null ? each.value.primary_key.name : "${each.value.name}_PK"
  type     = "PRIMARY KEY"
  table_id = "${snowflake_table.this[each.key].database}.${snowflake_table.this[each.key].schema}.${snowflake_table.this[each.key].name}"
  columns  = each.value.primary_key.keys
}
