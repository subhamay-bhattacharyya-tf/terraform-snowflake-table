# -----------------------------------------------------------------------------
# Terraform Snowflake Table Module
# -----------------------------------------------------------------------------
# This module creates and manages Snowflake tables using a map-based
# configuration. It supports creating single or multiple tables with
# columns, primary keys, clustering, change tracking, and data retention
# settings in a single module call.
# -----------------------------------------------------------------------------

locals {
  # Build column definitions for each table
  table_columns = {
    for k, v in var.table_configs : k => join(",\n      ", [
      for col in v.columns : format(
        "%s %s%s%s%s",
        col.name,
        col.type,
        col.nullable == false ? " NOT NULL" : "",
        col.default != null ? " DEFAULT ${col.default}" : "",
        col.comment != null ? " COMMENT '${replace(col.comment, "'", "''")}'" : ""
      )
    ])
  }

  # Build primary key constraint
  table_primary_keys = {
    for k, v in var.table_configs : k => v.primary_key != null ? format(
      ",\n      CONSTRAINT %s PRIMARY KEY (%s)",
      coalesce(v.primary_key.name, "${v.name}_PK"),
      join(", ", v.primary_key.keys)
    ) : ""
  }

  # Determine CREATE statement type based on drop_before_create flag
  create_statement = {
    for k, v in var.table_configs : k => (
      v.drop_before_create ? "CREATE OR REPLACE" : "CREATE"
    )
  }

  # Determine table type keyword
  table_type_keyword = {
    for k, v in var.table_configs : k => (
      v.table_type == "TRANSIENT" ? "TRANSIENT " :
      v.table_type == "TEMPORARY" ? "TEMPORARY " : ""
    )
  }

  # Build cluster by clause
  table_cluster_by = {
    for k, v in var.table_configs : k => (
      v.cluster_by != null ? "CLUSTER BY (${join(", ", v.cluster_by)})" : ""
    )
  }

  # Build comment clause
  table_comment = {
    for k, v in var.table_configs : k => (
      v.comment != null ? "COMMENT = '${replace(v.comment, "'", "''")}'" : ""
    )
  }
}

resource "snowflake_unsafe_execute" "table" {
  for_each = var.table_configs

  execute = <<-SQL
    ${local.create_statement[each.key]} ${local.table_type_keyword[each.key]}TABLE ${each.value.drop_before_create ? "" : "IF NOT EXISTS "}${each.value.database}.${each.value.schema}.${each.value.name}
    (
      ${local.table_columns[each.key]}${local.table_primary_keys[each.key]}
    )
    ${local.table_cluster_by[each.key]}
    DATA_RETENTION_TIME_IN_DAYS = ${each.value.data_retention_time_in_days}
    CHANGE_TRACKING = ${each.value.change_tracking ? "TRUE" : "FALSE"}
    ${local.table_comment[each.key]}
  SQL

  revert = <<-SQL
    DROP TABLE IF EXISTS ${each.value.database}.${each.value.schema}.${each.value.name}
  SQL
}
