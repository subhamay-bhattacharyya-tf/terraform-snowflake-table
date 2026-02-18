# -----------------------------------------------------------------------------
# Multiple Tables Example - Outputs
# -----------------------------------------------------------------------------

output "table_names" {
  description = "The names of the created tables"
  value       = module.tables.table_names
}

output "table_fully_qualified_names" {
  description = "The fully qualified names of the tables"
  value       = module.tables.table_fully_qualified_names
}

output "table_types" {
  description = "The types of the created tables"
  value       = module.tables.table_types
}
