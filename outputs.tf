# -----------------------------------------------------------------------------
# Terraform Snowflake Table Module
# -----------------------------------------------------------------------------
# This module creates and manages Snowflake tables using a map-based
# configuration. It supports creating single or multiple tables with
# columns, primary keys, clustering, change tracking, and data retention
# settings in a single module call.
# -----------------------------------------------------------------------------

output "table_names" {
  description = "The names of the created tables."
  value       = { for k, v in snowflake_table.this : k => v.name }
}

output "table_fully_qualified_names" {
  description = "The fully qualified names of the tables (database.schema.table)."
  value       = { for k, v in snowflake_table.this : k => "${v.database}.${v.schema}.${v.name}" }
}

output "table_databases" {
  description = "The databases containing the tables."
  value       = { for k, v in snowflake_table.this : k => v.database }
}

output "table_schemas" {
  description = "The schemas containing the tables."
  value       = { for k, v in snowflake_table.this : k => v.schema }
}

output "tables" {
  description = "All table resources."
  value       = snowflake_table.this
}

output "primary_key_constraints" {
  description = "All primary key constraint resources."
  value       = snowflake_table_constraint.primary_key
}
