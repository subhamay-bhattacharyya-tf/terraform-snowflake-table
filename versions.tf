# -----------------------------------------------------------------------------
# Terraform Snowflake Table Module
# -----------------------------------------------------------------------------
# This module creates and manages Snowflake tables using a map-based
# configuration. It supports creating single or multiple tables with
# columns, primary keys, clustering, change tracking, and data retention
# settings in a single module call.
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = ">= 1.0.0"
    }
  }
}
