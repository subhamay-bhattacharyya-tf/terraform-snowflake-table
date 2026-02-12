# -----------------------------------------------------------------------------
# Single Table Example - Outputs
# -----------------------------------------------------------------------------

output "table_names" {
  description = "The names of the created tables"
  value       = module.table.table_names
}

output "table_fully_qualified_names" {
  description = "The fully qualified names of the tables"
  value       = module.table.table_fully_qualified_names
}
