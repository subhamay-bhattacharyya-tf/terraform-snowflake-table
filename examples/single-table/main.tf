# -----------------------------------------------------------------------------
# Single Table Example
# -----------------------------------------------------------------------------

locals {
  default_table_configs = {
    "users_table" = {
      database = "MY_DATABASE"
      schema   = "PUBLIC"
      name     = "USERS"
      comment  = "User information table"
      columns = [
        {
          name     = "ID"
          type     = "NUMBER(38,0)"
          nullable = false
        },
        {
          name     = "EMAIL"
          type     = "VARCHAR(255)"
          nullable = false
        },
        {
          name     = "CREATED_AT"
          type     = "TIMESTAMP_NTZ"
          nullable = false
        }
      ]
      primary_key = {
        keys = ["ID"]
      }
    }
  }
}

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

  table_configs = coalesce(var.table_configs, local.default_table_configs)
}
