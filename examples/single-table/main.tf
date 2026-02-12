# -----------------------------------------------------------------------------
# Single Table Example
# -----------------------------------------------------------------------------

provider "snowflake" {
  organization_name = var.snowflake_organization_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  role              = var.snowflake_role
  private_key       = var.snowflake_private_key
  authenticator     = var.snowflake_private_key != null ? "SNOWFLAKE_JWT" : null
}

module "table" {
  source = "../../"

  table_configs = var.table_configs
}
